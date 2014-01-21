require 'spec_helper'

describe Viagogo::Response::RaiseError do
  def connection
    Faraday.new do |c|
      c.use described_class, {}

      c.adapter :test do |stub|
        yield(stub) if block_given?
      end
    end
  end

  [200, 204, 301, 302, 303, 307].each do |status|
    context "for an HTTP #{status} response" do
      it "should not raise an error" do
        expect { connection do |stub|
          stub.get('/') {[status, {}, '']}
        end.get('/')
        }.not_to raise_error
      end
    end
  end

  context "for an HTTP 400 response" do
    it "should raise a Viagogo::BadRequestError" do
      expect { connection do |stub|
        stub.get('/') {[400, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::BadRequestError
    end
  end

  context "for an HTTP 404 response" do
    it "should raise a Viagogo::NotFoundError" do
      expect { connection do |stub|
        stub.get('/') {[404, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::NotFoundError
    end
  end

  context "for an HTTP 405 response" do
    it "should raise a Viagogo::MethodNotAllowedError" do
      expect { connection do |stub|
        stub.get('/') {[405, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::MethodNotAllowedError
    end
  end

  context "for an HTTP 500 response" do
    it "should raise a Viagogo::InternalServerError" do
      expect { connection do |stub|
        stub.get('/') {[500, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::InternalServerError
    end
  end

  context "for an HTTP 403 response" do
    it "should raise a Viagogo::ForbiddenError" do
      expect { connection do |stub|
        stub.get('/') {[403, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::ForbiddenError
    end
  end

  context "for an HTTP 401 response" do
    it "should raise a Viagogo::UnauthorizedError" do
      expect { connection do |stub|
        stub.get('/') {[401, {}, '']}
      end.get('/')
      }.to raise_error Viagogo::UnauthorizedError
    end
  end

end