# # encoding: utf-8

# Inspec test for recipe artemis::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(61616) do
  it { should be_listening }
end

describe port(8161) do
  it { should be_listening }
end

describe port(5672) do
  it { should be_listening }
end

describe port(61613) do
  it { should_not be_listening }
end

describe directory('/opt/apache-artemis-2.4.0') do
  it { should exist }
end

describe directory('/var/lib/artemis') do
  it { should exist }
end
