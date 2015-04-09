require 'spec_helper'

describe TuftsGenericObject do

  it 'has methods to support a draft version of the object' do
    expect(TuftsGenericObject.respond_to?(:build_draft_version)).to be_truthy
  end

  describe "with access rights" do
    before do
      @generic_object = TuftsGenericObject.new(title: 'test generic', displays: ['dl'])
      @generic_object.read_groups = ['public']
      @generic_object.save!
    end

    after do
      @generic_object.destroy
    end

    let (:ability) {  Ability.new(nil) }

    it "should be visible to a not-signed-in user" do
      ability.can?(:read, @generic_object.pid).should be_truthy
    end
  end
end
