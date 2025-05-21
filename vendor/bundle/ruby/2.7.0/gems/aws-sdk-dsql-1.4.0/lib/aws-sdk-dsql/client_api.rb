# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE


module Aws::DSQL
  # @api private
  module ClientApi

    include Seahorse::Model

    AccessDeniedException = Shapes::StructureShape.new(name: 'AccessDeniedException')
    Arn = Shapes::StringShape.new(name: 'Arn')
    ClientToken = Shapes::StringShape.new(name: 'ClientToken')
    ClusterArn = Shapes::StringShape.new(name: 'ClusterArn')
    ClusterArnList = Shapes::ListShape.new(name: 'ClusterArnList')
    ClusterCreationTime = Shapes::TimestampShape.new(name: 'ClusterCreationTime')
    ClusterId = Shapes::StringShape.new(name: 'ClusterId')
    ClusterList = Shapes::ListShape.new(name: 'ClusterList')
    ClusterPropertyMap = Shapes::MapShape.new(name: 'ClusterPropertyMap')
    ClusterStatus = Shapes::StringShape.new(name: 'ClusterStatus')
    ClusterSummary = Shapes::StructureShape.new(name: 'ClusterSummary')
    ConflictException = Shapes::StructureShape.new(name: 'ConflictException')
    CreateClusterInput = Shapes::StructureShape.new(name: 'CreateClusterInput')
    CreateClusterOutput = Shapes::StructureShape.new(name: 'CreateClusterOutput')
    CreateMultiRegionClustersInput = Shapes::StructureShape.new(name: 'CreateMultiRegionClustersInput')
    CreateMultiRegionClustersOutput = Shapes::StructureShape.new(name: 'CreateMultiRegionClustersOutput')
    DeleteClusterInput = Shapes::StructureShape.new(name: 'DeleteClusterInput')
    DeleteClusterOutput = Shapes::StructureShape.new(name: 'DeleteClusterOutput')
    DeleteMultiRegionClustersInput = Shapes::StructureShape.new(name: 'DeleteMultiRegionClustersInput')
    DeletionProtectionEnabled = Shapes::BooleanShape.new(name: 'DeletionProtectionEnabled')
    GetClusterInput = Shapes::StructureShape.new(name: 'GetClusterInput')
    GetClusterOutput = Shapes::StructureShape.new(name: 'GetClusterOutput')
    Integer = Shapes::IntegerShape.new(name: 'Integer')
    InternalServerException = Shapes::StructureShape.new(name: 'InternalServerException')
    LinkedClusterProperties = Shapes::StructureShape.new(name: 'LinkedClusterProperties')
    ListClustersInput = Shapes::StructureShape.new(name: 'ListClustersInput')
    ListClustersOutput = Shapes::StructureShape.new(name: 'ListClustersOutput')
    ListTagsForResourceInput = Shapes::StructureShape.new(name: 'ListTagsForResourceInput')
    ListTagsForResourceOutput = Shapes::StructureShape.new(name: 'ListTagsForResourceOutput')
    MaxResults = Shapes::IntegerShape.new(name: 'MaxResults')
    NextToken = Shapes::StringShape.new(name: 'NextToken')
    Region = Shapes::StringShape.new(name: 'Region')
    RegionList = Shapes::ListShape.new(name: 'RegionList')
    ResourceNotFoundException = Shapes::StructureShape.new(name: 'ResourceNotFoundException')
    ServiceQuotaExceededException = Shapes::StructureShape.new(name: 'ServiceQuotaExceededException')
    String = Shapes::StringShape.new(name: 'String')
    TagKey = Shapes::StringShape.new(name: 'TagKey')
    TagKeyList = Shapes::ListShape.new(name: 'TagKeyList')
    TagMap = Shapes::MapShape.new(name: 'TagMap')
    TagResourceInput = Shapes::StructureShape.new(name: 'TagResourceInput')
    TagValue = Shapes::StringShape.new(name: 'TagValue')
    ThrottlingException = Shapes::StructureShape.new(name: 'ThrottlingException')
    UntagResourceInput = Shapes::StructureShape.new(name: 'UntagResourceInput')
    UpdateClusterInput = Shapes::StructureShape.new(name: 'UpdateClusterInput')
    UpdateClusterOutput = Shapes::StructureShape.new(name: 'UpdateClusterOutput')
    ValidationException = Shapes::StructureShape.new(name: 'ValidationException')
    ValidationExceptionField = Shapes::StructureShape.new(name: 'ValidationExceptionField')
    ValidationExceptionFieldList = Shapes::ListShape.new(name: 'ValidationExceptionFieldList')
    ValidationExceptionReason = Shapes::StringShape.new(name: 'ValidationExceptionReason')

    AccessDeniedException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    AccessDeniedException.struct_class = Types::AccessDeniedException

    ClusterArnList.member = Shapes::ShapeRef.new(shape: ClusterArn)

    ClusterList.member = Shapes::ShapeRef.new(shape: ClusterSummary)

    ClusterPropertyMap.key = Shapes::ShapeRef.new(shape: Region)
    ClusterPropertyMap.value = Shapes::ShapeRef.new(shape: LinkedClusterProperties)

    ClusterSummary.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location_name: "identifier"))
    ClusterSummary.add_member(:arn, Shapes::ShapeRef.new(shape: ClusterArn, required: true, location_name: "arn"))
    ClusterSummary.struct_class = Types::ClusterSummary

    ConflictException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ConflictException.add_member(:resource_id, Shapes::ShapeRef.new(shape: String, location_name: "resourceId"))
    ConflictException.add_member(:resource_type, Shapes::ShapeRef.new(shape: String, location_name: "resourceType"))
    ConflictException.struct_class = Types::ConflictException

    CreateClusterInput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, location_name: "deletionProtectionEnabled"))
    CreateClusterInput.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, location_name: "tags"))
    CreateClusterInput.add_member(:client_token, Shapes::ShapeRef.new(shape: ClientToken, location_name: "clientToken", metadata: {"idempotencyToken"=>true}))
    CreateClusterInput.struct_class = Types::CreateClusterInput

    CreateClusterOutput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location_name: "identifier"))
    CreateClusterOutput.add_member(:arn, Shapes::ShapeRef.new(shape: ClusterArn, required: true, location_name: "arn"))
    CreateClusterOutput.add_member(:status, Shapes::ShapeRef.new(shape: ClusterStatus, required: true, location_name: "status"))
    CreateClusterOutput.add_member(:creation_time, Shapes::ShapeRef.new(shape: ClusterCreationTime, required: true, location_name: "creationTime"))
    CreateClusterOutput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, required: true, location_name: "deletionProtectionEnabled"))
    CreateClusterOutput.struct_class = Types::CreateClusterOutput

    CreateMultiRegionClustersInput.add_member(:linked_region_list, Shapes::ShapeRef.new(shape: RegionList, required: true, location_name: "linkedRegionList"))
    CreateMultiRegionClustersInput.add_member(:cluster_properties, Shapes::ShapeRef.new(shape: ClusterPropertyMap, location_name: "clusterProperties"))
    CreateMultiRegionClustersInput.add_member(:witness_region, Shapes::ShapeRef.new(shape: Region, required: true, location_name: "witnessRegion"))
    CreateMultiRegionClustersInput.add_member(:client_token, Shapes::ShapeRef.new(shape: ClientToken, location_name: "clientToken", metadata: {"idempotencyToken"=>true}))
    CreateMultiRegionClustersInput.struct_class = Types::CreateMultiRegionClustersInput

    CreateMultiRegionClustersOutput.add_member(:linked_cluster_arns, Shapes::ShapeRef.new(shape: ClusterArnList, required: true, location_name: "linkedClusterArns"))
    CreateMultiRegionClustersOutput.struct_class = Types::CreateMultiRegionClustersOutput

    DeleteClusterInput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location: "uri", location_name: "identifier"))
    DeleteClusterInput.add_member(:client_token, Shapes::ShapeRef.new(shape: ClientToken, location: "querystring", location_name: "client-token", metadata: {"idempotencyToken"=>true}))
    DeleteClusterInput.struct_class = Types::DeleteClusterInput

    DeleteClusterOutput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location_name: "identifier"))
    DeleteClusterOutput.add_member(:arn, Shapes::ShapeRef.new(shape: ClusterArn, required: true, location_name: "arn"))
    DeleteClusterOutput.add_member(:status, Shapes::ShapeRef.new(shape: ClusterStatus, required: true, location_name: "status"))
    DeleteClusterOutput.add_member(:creation_time, Shapes::ShapeRef.new(shape: ClusterCreationTime, required: true, location_name: "creationTime"))
    DeleteClusterOutput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, required: true, location_name: "deletionProtectionEnabled"))
    DeleteClusterOutput.struct_class = Types::DeleteClusterOutput

    DeleteMultiRegionClustersInput.add_member(:linked_cluster_arns, Shapes::ShapeRef.new(shape: ClusterArnList, required: true, location: "querystring", location_name: "linked-cluster-arns"))
    DeleteMultiRegionClustersInput.add_member(:client_token, Shapes::ShapeRef.new(shape: ClientToken, location: "querystring", location_name: "client-token", metadata: {"idempotencyToken"=>true}))
    DeleteMultiRegionClustersInput.struct_class = Types::DeleteMultiRegionClustersInput

    GetClusterInput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location: "uri", location_name: "identifier"))
    GetClusterInput.struct_class = Types::GetClusterInput

    GetClusterOutput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location_name: "identifier"))
    GetClusterOutput.add_member(:arn, Shapes::ShapeRef.new(shape: ClusterArn, required: true, location_name: "arn"))
    GetClusterOutput.add_member(:status, Shapes::ShapeRef.new(shape: ClusterStatus, required: true, location_name: "status"))
    GetClusterOutput.add_member(:creation_time, Shapes::ShapeRef.new(shape: ClusterCreationTime, required: true, location_name: "creationTime"))
    GetClusterOutput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, required: true, location_name: "deletionProtectionEnabled"))
    GetClusterOutput.add_member(:witness_region, Shapes::ShapeRef.new(shape: Region, location_name: "witnessRegion"))
    GetClusterOutput.add_member(:linked_cluster_arns, Shapes::ShapeRef.new(shape: ClusterArnList, location_name: "linkedClusterArns"))
    GetClusterOutput.struct_class = Types::GetClusterOutput

    InternalServerException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    InternalServerException.add_member(:retry_after_seconds, Shapes::ShapeRef.new(shape: Integer, location: "header", location_name: "Retry-After"))
    InternalServerException.struct_class = Types::InternalServerException

    LinkedClusterProperties.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, location_name: "deletionProtectionEnabled"))
    LinkedClusterProperties.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, location_name: "tags"))
    LinkedClusterProperties.struct_class = Types::LinkedClusterProperties

    ListClustersInput.add_member(:max_results, Shapes::ShapeRef.new(shape: MaxResults, location: "querystring", location_name: "max-results"))
    ListClustersInput.add_member(:next_token, Shapes::ShapeRef.new(shape: NextToken, location: "querystring", location_name: "next-token"))
    ListClustersInput.struct_class = Types::ListClustersInput

    ListClustersOutput.add_member(:next_token, Shapes::ShapeRef.new(shape: NextToken, location_name: "nextToken"))
    ListClustersOutput.add_member(:clusters, Shapes::ShapeRef.new(shape: ClusterList, required: true, location_name: "clusters"))
    ListClustersOutput.struct_class = Types::ListClustersOutput

    ListTagsForResourceInput.add_member(:resource_arn, Shapes::ShapeRef.new(shape: Arn, required: true, location: "uri", location_name: "resourceArn"))
    ListTagsForResourceInput.struct_class = Types::ListTagsForResourceInput

    ListTagsForResourceOutput.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, location_name: "tags"))
    ListTagsForResourceOutput.struct_class = Types::ListTagsForResourceOutput

    RegionList.member = Shapes::ShapeRef.new(shape: Region)

    ResourceNotFoundException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ResourceNotFoundException.add_member(:resource_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceId"))
    ResourceNotFoundException.add_member(:resource_type, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceType"))
    ResourceNotFoundException.struct_class = Types::ResourceNotFoundException

    ServiceQuotaExceededException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ServiceQuotaExceededException.add_member(:resource_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceId"))
    ServiceQuotaExceededException.add_member(:resource_type, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceType"))
    ServiceQuotaExceededException.add_member(:service_code, Shapes::ShapeRef.new(shape: String, required: true, location_name: "serviceCode"))
    ServiceQuotaExceededException.add_member(:quota_code, Shapes::ShapeRef.new(shape: String, required: true, location_name: "quotaCode"))
    ServiceQuotaExceededException.struct_class = Types::ServiceQuotaExceededException

    TagKeyList.member = Shapes::ShapeRef.new(shape: TagKey)

    TagMap.key = Shapes::ShapeRef.new(shape: TagKey)
    TagMap.value = Shapes::ShapeRef.new(shape: TagValue)

    TagResourceInput.add_member(:resource_arn, Shapes::ShapeRef.new(shape: Arn, required: true, location: "uri", location_name: "resourceArn"))
    TagResourceInput.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, required: true, location_name: "tags"))
    TagResourceInput.struct_class = Types::TagResourceInput

    ThrottlingException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ThrottlingException.add_member(:service_code, Shapes::ShapeRef.new(shape: String, location_name: "serviceCode"))
    ThrottlingException.add_member(:quota_code, Shapes::ShapeRef.new(shape: String, location_name: "quotaCode"))
    ThrottlingException.add_member(:retry_after_seconds, Shapes::ShapeRef.new(shape: Integer, location: "header", location_name: "Retry-After"))
    ThrottlingException.struct_class = Types::ThrottlingException

    UntagResourceInput.add_member(:resource_arn, Shapes::ShapeRef.new(shape: Arn, required: true, location: "uri", location_name: "resourceArn"))
    UntagResourceInput.add_member(:tag_keys, Shapes::ShapeRef.new(shape: TagKeyList, required: true, location: "querystring", location_name: "tagKeys"))
    UntagResourceInput.struct_class = Types::UntagResourceInput

    UpdateClusterInput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location: "uri", location_name: "identifier"))
    UpdateClusterInput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, location_name: "deletionProtectionEnabled"))
    UpdateClusterInput.add_member(:client_token, Shapes::ShapeRef.new(shape: ClientToken, location_name: "clientToken", metadata: {"idempotencyToken"=>true}))
    UpdateClusterInput.struct_class = Types::UpdateClusterInput

    UpdateClusterOutput.add_member(:identifier, Shapes::ShapeRef.new(shape: ClusterId, required: true, location_name: "identifier"))
    UpdateClusterOutput.add_member(:arn, Shapes::ShapeRef.new(shape: ClusterArn, required: true, location_name: "arn"))
    UpdateClusterOutput.add_member(:status, Shapes::ShapeRef.new(shape: ClusterStatus, required: true, location_name: "status"))
    UpdateClusterOutput.add_member(:creation_time, Shapes::ShapeRef.new(shape: ClusterCreationTime, required: true, location_name: "creationTime"))
    UpdateClusterOutput.add_member(:deletion_protection_enabled, Shapes::ShapeRef.new(shape: DeletionProtectionEnabled, required: true, location_name: "deletionProtectionEnabled"))
    UpdateClusterOutput.add_member(:witness_region, Shapes::ShapeRef.new(shape: Region, location_name: "witnessRegion"))
    UpdateClusterOutput.add_member(:linked_cluster_arns, Shapes::ShapeRef.new(shape: ClusterArnList, location_name: "linkedClusterArns"))
    UpdateClusterOutput.struct_class = Types::UpdateClusterOutput

    ValidationException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ValidationException.add_member(:reason, Shapes::ShapeRef.new(shape: ValidationExceptionReason, required: true, location_name: "reason"))
    ValidationException.add_member(:field_list, Shapes::ShapeRef.new(shape: ValidationExceptionFieldList, location_name: "fieldList"))
    ValidationException.struct_class = Types::ValidationException

    ValidationExceptionField.add_member(:name, Shapes::ShapeRef.new(shape: String, required: true, location_name: "name"))
    ValidationExceptionField.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ValidationExceptionField.struct_class = Types::ValidationExceptionField

    ValidationExceptionFieldList.member = Shapes::ShapeRef.new(shape: ValidationExceptionField)


    # @api private
    API = Seahorse::Model::Api.new.tap do |api|

      api.version = "2018-05-10"

      api.metadata = {
        "apiVersion" => "2018-05-10",
        "auth" => ["aws.auth#sigv4"],
        "endpointPrefix" => "dsql",
        "protocol" => "rest-json",
        "protocols" => ["rest-json"],
        "serviceFullName" => "Amazon Aurora DSQL",
        "serviceId" => "DSQL",
        "signatureVersion" => "v4",
        "signingName" => "dsql",
        "uid" => "dsql-2018-05-10",
      }

      api.add_operation(:create_cluster, Seahorse::Model::Operation.new.tap do |o|
        o.name = "CreateCluster"
        o.http_method = "POST"
        o.http_request_uri = "/cluster"
        o.input = Shapes::ShapeRef.new(shape: CreateClusterInput)
        o.output = Shapes::ShapeRef.new(shape: CreateClusterOutput)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
      end)

      api.add_operation(:create_multi_region_clusters, Seahorse::Model::Operation.new.tap do |o|
        o.name = "CreateMultiRegionClusters"
        o.http_method = "POST"
        o.http_request_uri = "/multi-region-clusters"
        o.input = Shapes::ShapeRef.new(shape: CreateMultiRegionClustersInput)
        o.output = Shapes::ShapeRef.new(shape: CreateMultiRegionClustersOutput)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
      end)

      api.add_operation(:delete_cluster, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DeleteCluster"
        o.http_method = "DELETE"
        o.http_request_uri = "/cluster/{identifier}"
        o.input = Shapes::ShapeRef.new(shape: DeleteClusterInput)
        o.output = Shapes::ShapeRef.new(shape: DeleteClusterOutput)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
      end)

      api.add_operation(:delete_multi_region_clusters, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DeleteMultiRegionClusters"
        o.http_method = "DELETE"
        o.http_request_uri = "/multi-region-clusters"
        o.input = Shapes::ShapeRef.new(shape: DeleteMultiRegionClustersInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
      end)

      api.add_operation(:get_cluster, Seahorse::Model::Operation.new.tap do |o|
        o.name = "GetCluster"
        o.http_method = "GET"
        o.http_request_uri = "/cluster/{identifier}"
        o.input = Shapes::ShapeRef.new(shape: GetClusterInput)
        o.output = Shapes::ShapeRef.new(shape: GetClusterOutput)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
      end)

      api.add_operation(:list_clusters, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListClusters"
        o.http_method = "GET"
        o.http_request_uri = "/cluster"
        o.input = Shapes::ShapeRef.new(shape: ListClustersInput)
        o.output = Shapes::ShapeRef.new(shape: ListClustersOutput)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o[:pager] = Aws::Pager.new(
          limit_key: "max_results",
          tokens: {
            "next_token" => "next_token"
          }
        )
      end)

      api.add_operation(:list_tags_for_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListTagsForResource"
        o.http_method = "GET"
        o.http_request_uri = "/tags/{resourceArn}"
        o.input = Shapes::ShapeRef.new(shape: ListTagsForResourceInput)
        o.output = Shapes::ShapeRef.new(shape: ListTagsForResourceOutput)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
      end)

      api.add_operation(:tag_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "TagResource"
        o.http_method = "POST"
        o.http_request_uri = "/tags/{resourceArn}"
        o.input = Shapes::ShapeRef.new(shape: TagResourceInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
      end)

      api.add_operation(:untag_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UntagResource"
        o.http_method = "DELETE"
        o.http_request_uri = "/tags/{resourceArn}"
        o.input = Shapes::ShapeRef.new(shape: UntagResourceInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
      end)

      api.add_operation(:update_cluster, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateCluster"
        o.http_method = "POST"
        o.http_request_uri = "/cluster/{identifier}"
        o.input = Shapes::ShapeRef.new(shape: UpdateClusterInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateClusterOutput)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
      end)
    end

  end
end
