require 'spec_helper'

describe Viagogo do

  describe "::VERSION" do
    it "should have a value" do
      Viagogo::VERSION.should_not be_nil
    end
  end
end