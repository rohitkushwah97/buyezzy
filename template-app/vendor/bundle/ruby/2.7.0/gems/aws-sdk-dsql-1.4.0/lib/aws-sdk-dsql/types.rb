# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::DSQL
  module Types

    # You do not have sufficient access to perform this action.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/AccessDeniedException AWS API Documentation
    #
    class AccessDeniedException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # A summary of the properties of a cluster.
    #
    # @!attribute [rw] identifier
    #   The ID of the cluster.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the cluster.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ClusterSummary AWS API Documentation
    #
    class ClusterSummary < Struct.new(
      :identifier,
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # The submitted action has conflicts.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   Resource Id
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   Resource Type
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ConflictException AWS API Documentation
    #
    class ConflictException < Struct.new(
      :message,
      :resource_id,
      :resource_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] deletion_protection_enabled
    #   If enabled, you can't delete your cluster. You must first disable
    #   this property before you can delete your cluster.
    #   @return [Boolean]
    #
    # @!attribute [rw] tags
    #   A map of key and value pairs to use to tag your cluster.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes only once. With an idempotent request, if the original
    #   request completes successfully, the subsequent retries with the same
    #   client token return the result from the original successful request
    #   and they have no additional effect.
    #
    #   If you don't specify a client token, the Amazon Web Services SDK
    #   automatically generates one.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/CreateClusterInput AWS API Documentation
    #
    class CreateClusterInput < Struct.new(
      :deletion_protection_enabled,
      :tags,
      :client_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # Output Mixin
    #
    # @!attribute [rw] identifier
    #   The ID of the created cluster.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the created cluster.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the created cluster.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time of when created the cluster.
    #   @return [Time]
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Whether deletion protection is enabled on this cluster.
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/CreateClusterOutput AWS API Documentation
    #
    class CreateClusterOutput < Struct.new(
      :identifier,
      :arn,
      :status,
      :creation_time,
      :deletion_protection_enabled)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] linked_region_list
    #   An array of the Regions in which you want to create additional
    #   clusters.
    #   @return [Array<String>]
    #
    # @!attribute [rw] cluster_properties
    #   A mapping of properties to use when creating linked clusters.
    #   @return [Hash<String,Types::LinkedClusterProperties>]
    #
    # @!attribute [rw] witness_region
    #   The witness Region of multi-Region clusters.
    #   @return [String]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes only once. With an idempotent request, if the original
    #   request completes successfully. The subsequent retries with the same
    #   client token return the result from the original successful request
    #   and they have no additional effect.
    #
    #   If you don't specify a client token, the Amazon Web Services SDK
    #   automatically generates one.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/CreateMultiRegionClustersInput AWS API Documentation
    #
    class CreateMultiRegionClustersInput < Struct.new(
      :linked_region_list,
      :cluster_properties,
      :witness_region,
      :client_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] linked_cluster_arns
    #   An array that contains the ARNs of all linked clusters.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/CreateMultiRegionClustersOutput AWS API Documentation
    #
    class CreateMultiRegionClustersOutput < Struct.new(
      :linked_cluster_arns)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The ID of the cluster to delete.
    #   @return [String]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes only once. With an idempotent request, if the original
    #   request completes successfully. The subsequent retries with the same
    #   client token return the result from the original successful request
    #   and they have no additional effect.
    #
    #   If you don't specify a client token, the Amazon Web Services SDK
    #   automatically generates one.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/DeleteClusterInput AWS API Documentation
    #
    class DeleteClusterInput < Struct.new(
      :identifier,
      :client_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # Output Mixin
    #
    # @!attribute [rw] identifier
    #   The ID of the deleted cluster.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the deleted cluster.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the cluster.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time of when the cluster was created.
    #   @return [Time]
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Specifies whether deletion protection was enabled on the cluster.
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/DeleteClusterOutput AWS API Documentation
    #
    class DeleteClusterOutput < Struct.new(
      :identifier,
      :arn,
      :status,
      :creation_time,
      :deletion_protection_enabled)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] linked_cluster_arns
    #   The ARNs of the clusters linked to the cluster you want to delete.
    #   also deletes these clusters as part of the operation.
    #   @return [Array<String>]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes only once. With an idempotent request, if the original
    #   request completes successfully. The subsequent retries with the same
    #   client token return the result from the original successful request
    #   and they have no additional effect.
    #
    #   If you don't specify a client token, the Amazon Web Services SDK
    #   automatically generates one.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/DeleteMultiRegionClustersInput AWS API Documentation
    #
    class DeleteMultiRegionClustersInput < Struct.new(
      :linked_cluster_arns,
      :client_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The ID of the cluster to retrieve.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/GetClusterInput AWS API Documentation
    #
    class GetClusterInput < Struct.new(
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # Output Mixin
    #
    # @!attribute [rw] identifier
    #   The ID of the retrieved cluster.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the retrieved cluster.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the retrieved cluster.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time of when the cluster was created.
    #   @return [Time]
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Whether deletion protection is enabled in this cluster.
    #   @return [Boolean]
    #
    # @!attribute [rw] witness_region
    #   The witness Region of the cluster. Applicable only for multi-Region
    #   clusters.
    #   @return [String]
    #
    # @!attribute [rw] linked_cluster_arns
    #   The ARNs of the clusters linked to the retrieved cluster.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/GetClusterOutput AWS API Documentation
    #
    class GetClusterOutput < Struct.new(
      :identifier,
      :arn,
      :status,
      :creation_time,
      :deletion_protection_enabled,
      :witness_region,
      :linked_cluster_arns)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request processing has failed because of an unknown error,
    # exception or failure.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] retry_after_seconds
    #   Retry after seconds.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/InternalServerException AWS API Documentation
    #
    class InternalServerException < Struct.new(
      :message,
      :retry_after_seconds)
      SENSITIVE = []
      include Aws::Structure
    end

    # Properties of linked clusters.
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Whether deletion protection is enabled.
    #   @return [Boolean]
    #
    # @!attribute [rw] tags
    #   A map of key and value pairs the linked cluster is tagged with.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/LinkedClusterProperties AWS API Documentation
    #
    class LinkedClusterProperties < Struct.new(
      :deletion_protection_enabled,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   An optional parameter that specifies the maximum number of results
    #   to return. You can use nextToken to display the next page of
    #   results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If your initial ListClusters operation returns a nextToken, you can
    #   include the returned nextToken in following ListClusters operations,
    #   which returns results in the next page.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ListClustersInput AWS API Documentation
    #
    class ListClustersInput < Struct.new(
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If nextToken is returned, there are more results available. The
    #   value of nextToken is a unique pagination token for each page. To
    #   retrieve the next page, make the call again using the returned
    #   token.
    #   @return [String]
    #
    # @!attribute [rw] clusters
    #   An array of the returned clusters.
    #   @return [Array<Types::ClusterSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ListClustersOutput AWS API Documentation
    #
    class ListClustersOutput < Struct.new(
      :next_token,
      :clusters)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The ARN of the resource for which you want to list the tags.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ListTagsForResourceInput AWS API Documentation
    #
    class ListTagsForResourceInput < Struct.new(
      :resource_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] tags
    #   A map of key and value pairs that you used to tag your resource.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ListTagsForResourceOutput AWS API Documentation
    #
    class ListTagsForResourceOutput < Struct.new(
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # The resource could not be found.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   Hypothetical identifier of the resource which does not exist
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   Hypothetical type of the resource which does not exist
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ResourceNotFoundException AWS API Documentation
    #
    class ResourceNotFoundException < Struct.new(
      :message,
      :resource_id,
      :resource_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # The service limit was exceeded.
    #
    # @!attribute [rw] message
    #   Description of the error
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   Identifier of the resource affected
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   Type of the resource affected
    #   @return [String]
    #
    # @!attribute [rw] service_code
    #   Service Quotas requirement to identify originating service
    #   @return [String]
    #
    # @!attribute [rw] quota_code
    #   Service Quotas requirement to identify originating quota
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ServiceQuotaExceededException AWS API Documentation
    #
    class ServiceQuotaExceededException < Struct.new(
      :message,
      :resource_id,
      :resource_type,
      :service_code,
      :quota_code)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The ARN of the resource that you want to tag.
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   A map of key and value pairs to use to tag your resource.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/TagResourceInput AWS API Documentation
    #
    class TagResourceInput < Struct.new(
      :resource_arn,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request was denied due to request throttling.
    #
    # @!attribute [rw] message
    #   Description of the error
    #   @return [String]
    #
    # @!attribute [rw] service_code
    #   Service Quotas requirement to identify originating service
    #   @return [String]
    #
    # @!attribute [rw] quota_code
    #   Service Quotas requirement to identify originating quota
    #   @return [String]
    #
    # @!attribute [rw] retry_after_seconds
    #   Advice to clients on when the call can be safely retried
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ThrottlingException AWS API Documentation
    #
    class ThrottlingException < Struct.new(
      :message,
      :service_code,
      :quota_code,
      :retry_after_seconds)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The ARN of the resource from which to remove tags.
    #   @return [String]
    #
    # @!attribute [rw] tag_keys
    #   The array of keys of the tags that you want to remove.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/UntagResourceInput AWS API Documentation
    #
    class UntagResourceInput < Struct.new(
      :resource_arn,
      :tag_keys)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The ID of the cluster you want to update.
    #   @return [String]
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Specifies whether to enable deletion protection in your cluster.
    #   @return [Boolean]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes only once. With an idempotent request, if the original
    #   request completes successfully. The subsequent retries with the same
    #   client token return the result from the original successful request
    #   and they have no additional effect.
    #
    #   If you don't specify a client token, the Amazon Web Services SDK
    #   automatically generates one.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/UpdateClusterInput AWS API Documentation
    #
    class UpdateClusterInput < Struct.new(
      :identifier,
      :deletion_protection_enabled,
      :client_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # Output Mixin
    #
    # @!attribute [rw] identifier
    #   The ID of the cluster to update.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the updated cluster.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the updated cluster.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time of when the cluster was created.
    #   @return [Time]
    #
    # @!attribute [rw] deletion_protection_enabled
    #   Whether deletion protection is enabled for the updated cluster.
    #   @return [Boolean]
    #
    # @!attribute [rw] witness_region
    #   The Region that receives all data you write to linked clusters.
    #   @return [String]
    #
    # @!attribute [rw] linked_cluster_arns
    #   The ARNs of the clusters linked to the updated cluster. Applicable
    #   only for multi-Region clusters.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/UpdateClusterOutput AWS API Documentation
    #
    class UpdateClusterOutput < Struct.new(
      :identifier,
      :arn,
      :status,
      :creation_time,
      :deletion_protection_enabled,
      :witness_region,
      :linked_cluster_arns)
      SENSITIVE = []
      include Aws::Structure
    end

    # The input failed to satisfy the constraints specified by an Amazon Web
    # Services service.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] reason
    #   Reason the request failed validation
    #   @return [String]
    #
    # @!attribute [rw] field_list
    #   List of fields that caused the error
    #   @return [Array<Types::ValidationExceptionField>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ValidationException AWS API Documentation
    #
    class ValidationException < Struct.new(
      :message,
      :reason,
      :field_list)
      SENSITIVE = []
      include Aws::Structure
    end

    # Stores information about a field passed inside a request that resulted
    # in an validation error.
    #
    # @!attribute [rw] name
    #   The name of the field.
    #   @return [String]
    #
    # @!attribute [rw] message
    #   A message describing why this field failed validation.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/dsql-2018-05-10/ValidationExceptionField AWS API Documentation
    #
    class ValidationExceptionField < Struct.new(
      :name,
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

  end
end

