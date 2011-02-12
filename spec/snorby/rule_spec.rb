require 'spec_helper'
require 'snorby/rule'

describe Snorby::Rule do
  it "should have a VERSION constant" do
    Snorby::Rule.const_get('VERSION').should_not be_empty
  end
end
