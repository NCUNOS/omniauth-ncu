require 'spec_helper'

describe OmniAuth::Strategies::NCU do
  let!(:info_endpoint) { 'personnel/v1/info' }
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:response) { double('Response', :parsed => {}) }
  let(:student_response) { double('Response', :parsed => {
    'name' => 'Steve',
    'type' => 'STUDENT',
    'unit' => 'test unit',
    'group' => 'test group',
    'number' => '123456789'
  }) }
  let(:faculty_response) { double('Response', :parsed => {
    'name' => 'Steve',
    'type' => 'FACULTY',
    'unit' => 'test unit',
    'title' => 'test title'
  }) }

  subject do
    OmniAuth::Strategies::NCU.new({})
  end

  before :each do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq("https://api.cc.ncu.edu.tw")
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://api.cc.ncu.edu.tw/oauth/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://api.cc.ncu.edu.tw/oauth/oauth/token')
    end
  end

  context "#info_allowed?" do
    it "should allow raw_info if scope is nil by filling default scope" do
      expect(subject.options['scope']).to be_nil
      expect(subject.info_allowed?).to be true
    end

    it "should allow raw_info if scope is user.info.basic.read" do
      allow(subject.options).to receive(:[]).with('scope').and_return %w(user.info.basic.read)
      expect(subject.info_allowed?).to be true
    end

    it "should allow raw_info if scope has included user.info.basic.read" do
      allow(subject.options).to receive(:[]).with('scope').and_return %w(user.info.basic.read course.schedule.read)
      expect(subject.info_allowed?).to be true
    end

    it "should not allow raw_info if scope does not grant email access" do
      allow(subject.options).to receive(:[]).with('scope').and_return %w(course.schedule.read)
      expect(subject.info_allowed?).to be false
    end

    it "should assume raw_info access not allowed if scope is something currently not documented " do
      allow(subject.options).to receive(:[]).with('scope').and_return %w(currently_not_documented)
      expect(subject.info_allowed?).to be false
    end
  end

  context "#raw_info" do
    it "should return empty Hash if info not allowed" do
      allow(subject).to receive(:info_allowed?).and_return false
      expect(subject.raw_info.class).to be Hash
      expect(subject.raw_info).to be_empty
    end
    it "should return correct info" do
      allow(subject).to receive(:info_allowed?).and_return true
      expect(access_token).to receive(:get).with(info_endpoint).and_return response
      expect(subject.raw_info).to eq(response.parsed)
    end
  end

  context "#info" do
    before :each do
      allow(subject).to receive(:info_allowed?).and_return true
    end
    it "should return student info if type is STUDENT" do
      allow(subject).to receive(:raw_info).and_return student_response.parsed
      expect(subject.info).to eq(student_response.parsed)
    end
    it "should return faculty info if type is FACULTY" do
      allow(subject).to receive(:raw_info).and_return faculty_response.parsed
      expect(subject.info).to eq(faculty_response.parsed)
    end
  end
end
