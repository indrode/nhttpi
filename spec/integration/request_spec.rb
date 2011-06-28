require "spec_helper"
require "nhttpi"
require "integration/server"

MockServer.new(IntegrationServer, 4000).start

describe NHTTPI do
  let(:client) { NHTTPI }

  before :all do
    WebMock.allow_net_connect!
    
    @username = "admin"
    @password = "pwd"
    @error_message = "Authorization Required"
    @example_web_page = "Hello"
    @content_type = "text/plain"
  end

  shared_examples_for "an HTTP client" do
    it "and send HTTP headers" do
      request = NHTTPI::Request.new :url => "http://localhost:4000/x-header"
      request.headers["X-Header"] = "NHTTPI"

      response = NHTTPI.get request, adapter
      response.body.should include("X-Header is NHTTPI")
    end

    it "and execute an HTTP GET request" do
      response = NHTTPI.get "http://localhost:4000", adapter
      response.body.should include(@example_web_page)
      response.headers["Content-Type"].should include(@content_type)
    end

    it "and execute an HTTP POST request" do
      response = NHTTPI.post "http://localhost:4000", "<some>xml</some>", adapter
      response.body.should include(@example_web_page)
      response.headers["Content-Type"].should include(@content_type)
    end

    it "and execute an HTTP HEAD request" do
      response = NHTTPI.head "http://localhost:4000", adapter
      response.code.should == 200
      response.headers["Content-Type"].should include(@content_type)
    end

    it "and execute an HTTP PUT request" do
      response = NHTTPI.put "http://localhost:4000", "<some>xml</some>", adapter
      response.body.should include("PUT is not allowed")
      response.headers["Content-Type"].should include(@content_type)
    end

    it "and execute an HTTP DELETE request" do
      response = NHTTPI.delete "http://localhost:4000", adapter
      response.body.should include("DELETE is not allowed")
      response.headers["Content-Type"].should include(@content_type)
    end
  end

  shared_examples_for "it works with HTTP basic auth" do
    it "and access a secured page" do
      request = NHTTPI::Request.new :url => "http://localhost:4000/auth/basic"
      request.auth.basic @username, @password

      response = NHTTPI.get request, adapter
      response.body.should_not include(@error_message)
    end
  end

  shared_examples_for "it works with HTTP digest auth" do
    it "and access a secured page" do
      request = NHTTPI::Request.new :url => "http://localhost:4000/auth/digest"
      request.auth.digest @username, @password

      response = NHTTPI.get request, adapter
      response.body.should_not include(@error_message)
    end
  end

  NHTTPI::Adapter::ADAPTERS.keys.each do |adapter|
    context "using :#{adapter}" do
      let(:adapter) { adapter }
      it_should_behave_like "an HTTP client"
      it_should_behave_like "it works with HTTP basic auth"
    end
  end

  (NHTTPI::Adapter::ADAPTERS.keys - [:net_http]).each do |adapter|
    context "using :#{adapter}" do
      let(:adapter) { adapter }
      it_should_behave_like "it works with HTTP digest auth"
    end
  end

end
