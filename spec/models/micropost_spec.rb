require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) } #from the associations, not defined directly
  its(:user) { should eq user } #Check that it matches the factorygirl user

  it { should be_valid }

  #First simple check to make sure a micropost can't have nil as its user_id
  describe "when user_id is not present" do
  	before { @micropost.user_id = nil }
  	it { should_not be_valid }
  end

end
