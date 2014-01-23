require 'spec_helper'

describe Viagogo::Response::UnderscorifyHash do
  def connection
    Faraday.new do |c|
      c.use described_class

      c.adapter :test do |stub|
        yield(stub) if block_given?
      end
    end
  end

  context "when response body is not Hash" do
    it "should not modify response" do
      ["foo", nil, [0,1,2]].each do |expected_body|
        expect(connection do |stub|
          stub.get('/') {[200, {}, expected_body]}
        end.get('/').body).to eq(expected_body)
      end
    end
  end

  context "when response body is a Hash" do
    it "should not modify non-CamelCase keys" do
      expected_body = { :not_camel_case => true, 5 => {"foo" => "bar"} }
      expect(connection do |stub|
        stub.get('/') {[200, {}, expected_body]}
      end.get('/').body).to eq(expected_body)
    end
    it "should not modify symbol keys" do
      expected_body = { :CamelCaseSymbol => true }
      expect(connection do |stub|
        stub.get('/') {[200, {}, expected_body]}
      end.get('/').body).to eq(expected_body)
    end

    it "should underscore-ify CamelCase string keys" do
      expect(connection do |stub|
        stub.get('/') {[200, {}, {"CamelCase" => 5, 'UnderscorifyMe' => { "AnotherCamelCase" => [5,6,7] }}]}
      end.get('/').body).to eq({"camel_case" => 5, "underscorify_me" => { "another_camel_case" => [5,6,7] }})
    end
  end

  context "when response body is an Array" do
    it "should underscore-ify CamelCase string keys of hash elements" do
      expect(connection do |stub|
        stub.get('/') {[200, {}, [{"CamelCase" => 5}, 'UnderscorifyMe' => [[{ "AnotherCamelCase" => [5,6,7] }]]]]}
      end.get('/').body).to eq([{"camel_case" => 5}, "underscorify_me" => [[{ "another_camel_case" => [5,6,7] }]]])
    end
  end
end
