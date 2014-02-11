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

module CumulogicClient
  class Nosql
    def initialize(api_url, username, password, use_ssl=nil, debug=false)
      @client = CumulogicClient::BaseClient.new(api_url, username, password, use_ssl, debug)
    end

    def engine_list()
      return @client.call('nosql/nosqlengine/list')
    end

    def list()
      return @client.call('nosql/instance/list')
    end

    def get(instanceId)
      return @client.call('nosql/instance/getAllHostByNoSqlInstanceID', wrapParam(instanceId))
    end

    def events(instanceId)
      return @client.call('nosql/instance/showEvents', wrapParams(instanceId))
    end

    def wrapParam(instanceId)
      {
        'noSqlInstanceId' => instanceId
      }
    end

    def terminate(instanceId)
      return @client.call('nosql/instance/terminateNoSqlInstance', wrapParam(instanceId))
    end

    def delete(instanceId)
      return @client.call('nosql/instance/deleteNoSqlInstance', wrapParam(instanceId))
    end

    def create(spec)
      response = @client.call('nosql/instance/createNoSqlInstance', spec.to_hash)
      @newInstanceId = response[0]['noSqlInstanceId']
      @client.provisioning_completed(self, 30)
      return @newInstanceId
    end

    def isComplete()
      instances = self.list()
      puts instances
      target = instances.select { |id| id["noSqlInstanceId"] = @newInstanceId }
      return false if (target[0]["status"] == 2)
      raise RuntimeError, "Error provisioning instance: #{target[0]["errorMessage"]}" if (target[0]["status"] == 3)
      return true
    end

    NoSQLSpec = Class.new do
      attr_accessor :name
      attr_accessor :description
      attr_accessor :nodes
      attr_accessor :collectionName
      attr_accessor :characterSet
      attr_accessor :port
      attr_accessor :noSqlEngineId
      attr_accessor :targetCloudId
      attr_accessor :availabilityZoneName
      attr_accessor :instanceTypeId
      attr_accessor :serviceTag
      attr_accessor :accessGroupId
      attr_accessor :noSqlParamGroupId
      attr_accessor :storageSize
      attr_accessor :isbackupPreferenceSet
      attr_accessor :isAutoUpdateEnabled
      attr_accessor :backupRetentionPeriod
      attr_accessor :backupStartTime
      attr_accessor :ownerType
      attr_accessor :isAvailabilityZoneMandatory
      attr_accessor :isInstanceTypeMandatory
      attr_accessor :availabilityZone
      attr_accessor :isVolumeSizeMandatory
      attr_accessor :backupRetentionPeriod
      attr_accessor :backupStartTime
      attr_accessor :start

      def to_hash
        Hash[*instance_variables.map { |v| [v.to_s().tr("@", ""), instance_variable_get(v)] }.flatten]
      end
    end

  end
end
