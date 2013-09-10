require 'test_helper'

class ClientTest < Minitest::Unit::TestCase

  def test_client_requires_host_argument
    assert_raises(ArgumentError) { DiscourseApi::Client.new }
  end

  def test_client_port_default_is_80
    client = DiscourseApi::Client.new('localhost')
    assert_equal(80, client.port)
  end

  def test_client_accepts_port_argument
    client = DiscourseApi::Client.new('localhost',3000)
    assert_equal(3000, client.port)
  end

  def test_client_responds_to_topic
    client = DiscourseApi::Client.new("localhost")
    assert_respond_to(client, :topic)

    stub_request(:get, /\/t\/[0-9]*\.json/)
      .to_return(:body=>'{"hello": "world"}')

    assert_equal client.topic(id: 1), {"hello" => "world"}
  end

  def test_client_responds_to_topic_invite_user
    client = DiscourseApi::Client.new('localhost')
    assert_respond_to(client, :topic_invite_user)
  end

  def test_client_responds_to_topics_latest
    client = DiscourseApi::Client.new('localhost')
    assert_respond_to(client, :topics_latest)

    stub_request(:get, "localhost/latest.json")
      .to_return(:body=>'{"hello": "world"}')

    assert_equal client.topics_latest, {"hello" => "world"}
  end

  def test_client_responds_to_topics_hot
    client = DiscourseApi::Client.new('localhost')
    assert_respond_to(client, :topics_hot)

    stub_request(:get, "localhost/hot.json")
      .to_return(:body=>'{"hello": "world"}')

    assert_equal client.topics_hot, {"hello" => "world"}
  end

  def test_client_responds_to_categories
    client = DiscourseApi::Client.new('localhost')
    assert_respond_to(client, :categories)

    stub_request(:get, "localhost/categories.json")
      .to_return(:body=>'{"hello": "world"}')

    assert_equal client.categories, {"hello" => "world"}
  end

end
