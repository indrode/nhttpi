require "spec_helper"
require "nhttpi"

describe NHTTPI do
  let(:client) { NHTTPI }
  let(:httpclient) { NHTTPI::Adapter.load(:httpclient)[1] }
  let(:curb) { NHTTPI::Adapter.load(:curb)[1] }

  describe ".get(request)" do
    it "executes a GET request using the default adapter" do
      request = NHTTPI::Request.new
      httpclient.any_instance.expects(:get).with(request)

      client.get request
    end
  end

  describe ".get(request, adapter)" do
    it "executes a GET request using the given adapter" do
      request = NHTTPI::Request.new
      curb.any_instance.expects(:get).with(request)

      client.get request, :curb
    end
  end

  describe ".get(url)" do
    it "executes a GET request using the default adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      httpclient.any_instance.expects(:get).with(instance_of(NHTTPI::Request))

      client.get "http://example.com"
    end
  end

  describe ".get(url, adapter)" do
    it "executes a GET request using the given adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      curb.any_instance.expects(:get).with(instance_of(NHTTPI::Request))

      client.get "http://example.com", :curb
    end
  end

  describe ".post(request)" do
    it "executes a POST request using the default adapter" do
      request = NHTTPI::Request.new
      httpclient.any_instance.expects(:post).with(request)

      client.post request
    end
  end

  describe ".post(request, adapter)" do
    it "executes a POST request using the given adapter" do
      request = NHTTPI::Request.new
      curb.any_instance.expects(:post).with(request)

      client.post request, :curb
    end
  end

  describe ".post(url, body)" do
    it "executes a POST request using the default adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      NHTTPI::Request.any_instance.expects(:body=).with("<some>xml</some>")
      httpclient.any_instance.expects(:post).with(instance_of(NHTTPI::Request))

      client.post "http://example.com", "<some>xml</some>"
    end
  end

  describe ".post(url, body, adapter)" do
    it "executes a POST request using the given adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      NHTTPI::Request.any_instance.expects(:body=).with("<some>xml</some>")
      curb.any_instance.expects(:post).with(instance_of(NHTTPI::Request))

      client.post "http://example.com", "<some>xml</some>", :curb
    end
  end

  describe ".head(request)" do
    it "executes a HEAD request using the default adapter" do
      request = NHTTPI::Request.new
      httpclient.any_instance.expects(:head).with(request)

      client.head request
    end
  end

  describe ".head(request, adapter)" do
    it "executes a HEAD request using the given adapter" do
      request = NHTTPI::Request.new
      curb.any_instance.expects(:head).with(request)

      client.head request, :curb
    end
  end

  describe ".head(url)" do
    it "executes a HEAD request using the default adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      httpclient.any_instance.expects(:head).with(instance_of(NHTTPI::Request))

      client.head "http://example.com"
    end
  end

  describe ".head(url, adapter)" do
    it "executes a HEAD request using the given adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      curb.any_instance.expects(:head).with(instance_of(NHTTPI::Request))

      client.head "http://example.com", :curb
    end
  end

  describe ".put(request)" do
    it "executes a PUT request using the default adapter" do
      request = NHTTPI::Request.new
      httpclient.any_instance.expects(:put).with(request)

      client.put request
    end
  end

  describe ".put(request, adapter)" do
    it "executes a PUT request using the given adapter" do
      request = NHTTPI::Request.new
      curb.any_instance.expects(:put).with(request)

      client.put request, :curb
    end
  end

  describe ".put(url, body)" do
    it "executes a PUT request using the default adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      NHTTPI::Request.any_instance.expects(:body=).with("<some>xml</some>")
      httpclient.any_instance.expects(:put).with(instance_of(NHTTPI::Request))

      client.put "http://example.com", "<some>xml</some>"
    end
  end

  describe ".put(url, body, adapter)" do
    it "executes a PUT request using the given adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      NHTTPI::Request.any_instance.expects(:body=).with("<some>xml</some>")
      curb.any_instance.expects(:put).with(instance_of(NHTTPI::Request))

      client.put "http://example.com", "<some>xml</some>", :curb
    end
  end

  describe ".delete(request)" do
    it "executes a DELETE request using the default adapter" do
      request = NHTTPI::Request.new
      httpclient.any_instance.expects(:delete).with(request)

      client.delete request
    end
  end

  describe ".delete(request, adapter)" do
    it "executes a DELETE request using the given adapter" do
      request = NHTTPI::Request.new
      curb.any_instance.expects(:delete).with(request)

      client.delete request, :curb
    end
  end

  describe ".delete(url)" do
    it "executes a DELETE request using the default adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      httpclient.any_instance.expects(:delete).with(instance_of(NHTTPI::Request))

      client.delete "http://example.com"
    end
  end

  describe ".delete(url, adapter)" do
    it "executes a DELETE request using the given adapter" do
      NHTTPI::Request.any_instance.expects(:url=).with("http://example.com")
      curb.any_instance.expects(:delete).with(instance_of(NHTTPI::Request))

      client.delete "http://example.com", :curb
    end
  end

  describe ".request" do
    it "raises an ArgumentError in case of an invalid request method" do
      expect { client.request :invalid, NHTTPI::Request.new }.to raise_error(ArgumentError)
    end
  end

  describe ".adapter=" do
    it "sets the default adapter to use" do
      NHTTPI::Adapter.expects(:use=).with(:net_http)
      NHTTPI.adapter = :net_http
    end
  end

  NHTTPI::REQUEST_METHODS.each do |method|
    describe ".request(#{method}, request, adapter)" do
      it "delegates to the .#{method} method" do
        NHTTPI.expects(method)
        client.request method, NHTTPI::Request.new
      end
    end

    describe ".#{method}" do
      let(:request) { NHTTPI::Request.new :url => "http://example.com" }

      it "raises an ArgumentError in case of an invalid adapter" do
        expect { client.request method, request, :invalid }.to raise_error(ArgumentError)
      end

      it "raises an ArgumentError in case of an invalid request" do
        expect { client.request method, "invalid" }.to raise_error(ArgumentError)
      end

      NHTTPI::Adapter::ADAPTERS.each do |adapter, opts|
        client_class = {
          :httpclient => lambda { HTTPClient },
          :curb       => lambda { Curl::Easy },
          :net_http   => lambda { Net::HTTP }
        }

        context "using #{adapter}" do
          before { opts[:class].any_instance.expects(method) }

          it "logs that we're executing a request" do
            NHTTPI.expects(:log).with(:debug, "NHTTPI executes HTTP #{method.to_s.upcase} using the #{adapter} adapter")
            client.request method, request, adapter
          end

          it "yields the HTTP client instance used for the request" do
            block = lambda { |http| http.be_a(client_class[adapter].call) }
            client.request(method, request, adapter, &block)
          end
        end
      end
    end
  end

  context "(with reset)" do
    before { NHTTPI.reset_config! }

    after do
      NHTTPI.reset_config!
      NHTTPI.log = false  # disable for specs
    end

    describe ".log" do
      it "defaults to true" do
        NHTTPI.log?.should be_true
      end
    end

    describe ".logger" do
      it "defaults to Logger writing to STDOUT" do
        NHTTPI.logger.should be_a(Logger)
      end
    end

    describe ".log_level" do
      it "defaults to :warn" do
        NHTTPI.log_level.should == :warn
      end
    end

    describe ".log" do
      it "logs the given messages" do
        NHTTPI.log_level = :debug
        NHTTPI.logger.expects(:debug).with("Log this")
        NHTTPI.log "Log", "this"
      end
    end
  end

end
