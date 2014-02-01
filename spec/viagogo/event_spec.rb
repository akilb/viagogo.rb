require 'spec_helper'

describe Viagogo::Event do
  describe "#start_datetime_utc" do
    it "should be a datetime representing the parsed date" do
      event = Viagogo::Event.new.extend(Viagogo::EventRepresenter).
                from_json("{\"StartDateTimeUtc\":\"/Date(628318530000)/\"}")
      expect(event.start_datetime_utc).to eq(DateTime.new(1989,11,29,4,55,30,"+0"))
    end
  end

  describe "#end_datetime_utc" do
    it "should be a datetime representing the parsed date" do
      event = Viagogo::Event.new.extend(Viagogo::EventRepresenter).
          from_json("{\"EndDateTimeUtc\":\"/Date(628318530000)/\"}")
      expect(event.end_datetime_utc).to eq(DateTime.new(1989,11,29,4,55,30,"+0"))
    end
  end

  describe "#start_datetime_local" do
    it "should be a datetime representing the parsed date" do
      event = Viagogo::Event.new.extend(Viagogo::EventRepresenter).
          from_json("{\"StartDateTimeLocal\":\"/Date(628318530000-0500)/\"}")
      expect(event.start_datetime_local).to eq(DateTime.new(1989,11,29,4,55,30,"-5"))
    end
  end

  describe "#end_datetime_local" do
    it "should be a datetime representing the parsed date" do
      event = Viagogo::Event.new.extend(Viagogo::EventRepresenter).
          from_json("{\"EndDateTimeLocal\":\"/Date(628318530000+0300)/\"}")
      expect(event.end_datetime_local).to eq(DateTime.new(1989,11,29,4,55,30,"+3"))
    end
  end
end
