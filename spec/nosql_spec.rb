# Copyright 2014 CumuLogic, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'cumulogic_client'
require 'yaml'

describe "base_client" do
  before(:all) do
    cnf = YAML::load(File.open(File.expand_path('~/.cumulogic_client.yml')))
    @URL = cnf['URL']
    @USER = cnf['USER']
    @PASSWORD = cnf['PASSWORD']
    @SSL = (cnf['SSL']) || false
    @DEBUG = (cnf['DEBUG']) || false
    @client = CumulogicClient::BaseClient.new(@URL, @USER, @PASSWORD, @SSL, @DEBUG)
  end
  it "can log in" do
    @client.login()
  end
  it "can get DB engine list" do
    @client.call("dbaas/dbengine/list")
  end
end

describe "nosql" do
  before(:all) do
    cnf = YAML::load(File.open(File.expand_path('~/.cumulogic_client.yml')))
    @URL = cnf['URL']
    @USER = cnf['USER']
    @PASSWORD = cnf['PASSWORD']
    @SSL = (cnf['SSL']) || false
    @nosql = CumulogicClient::Nosql.new(@URL, @USER, @PASSWORD, @SSL)
  end
  it "can get engine list" do
    @nosql.engine_list()
  end
  it "can create nosql instance" do
    # pass
  end
  it "can list nosql instances" do
    # pass 
  end
  it "can clone nosql instance" do
    # pass
  end
  it "can restart nosql instance" do
    # pass
  end
  it "can get nosql instance" do
    # pass
  end
  it "can terminate nosql instance" do
    # pass
  end
  it "can create nosql snapshot" do
    # pass
  end
  it "can list nosql snapshots" do
    # pass
  end
  it "can list nosql snapshot events" do
    # pass
  end
  it "can restore from snapshot" do
    # pass
  end
end
