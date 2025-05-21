# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::Billing
  module Types

    # You don't have sufficient access to perform this action.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/AccessDeniedException AWS API Documentation
    #
    class AccessDeniedException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # A time range with a start and end time.
    #
    # @!attribute [rw] active_after_inclusive
    #   The inclusive time range start date.
    #   @return [Time]
    #
    # @!attribute [rw] active_before_inclusive
    #   The inclusive time range end date.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ActiveTimeRange AWS API Documentation
    #
    class ActiveTimeRange < Struct.new(
      :active_after_inclusive,
      :active_before_inclusive)
      SENSITIVE = []
      include Aws::Structure
    end

    # The metadata associated to the billing view.
    #
    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   A list of names of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] billing_view_type
    #   The type of billing group.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The list of owners of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] data_filter_expression
    #   See [Expression][1]. Billing view only supports `LINKED_ACCOUNT` and
    #   `Tags`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html
    #   @return [Types::Expression]
    #
    # @!attribute [rw] created_at
    #   The time when the billing view was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The time when the billing view was last updated.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/BillingViewElement AWS API Documentation
    #
    class BillingViewElement < Struct.new(
      :arn,
      :name,
      :description,
      :billing_view_type,
      :owner_account_id,
      :data_filter_expression,
      :created_at,
      :updated_at)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # A representation of a billing view.
    #
    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   A list of names of the Billing view.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The list of owners of the Billing view.
    #   @return [String]
    #
    # @!attribute [rw] billing_view_type
    #   The type of billing view.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/BillingViewListElement AWS API Documentation
    #
    class BillingViewListElement < Struct.new(
      :arn,
      :name,
      :description,
      :owner_account_id,
      :billing_view_type)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # The requested operation would cause a conflict with the current state
    # of a service resource associated with the request. Resolve the
    # conflict before retrying this request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   The identifier for the service resource associated with the request.
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   The type of resource associated with the request.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ConflictException AWS API Documentation
    #
    class ConflictException < Struct.new(
      :message,
      :resource_id,
      :resource_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] source_views
    #   A list of billing views used as the data source for the custom
    #   billing view.
    #   @return [Array<String>]
    #
    # @!attribute [rw] data_filter_expression
    #   See [Expression][1]. Billing view only supports `LINKED_ACCOUNT` and
    #   `Tags`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html
    #   @return [Types::Expression]
    #
    # @!attribute [rw] client_token
    #   A unique, case-sensitive identifier you specify to ensure
    #   idempotency of the request. Idempotency ensures that an API request
    #   completes no more than one time. If the original request completes
    #   successfully, any subsequent retries complete successfully without
    #   performing any further actions with an idempotent request.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] resource_tags
    #   A list of key value map specifying tags associated to the billing
    #   view being created.
    #   @return [Array<Types::ResourceTag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/CreateBillingViewRequest AWS API Documentation
    #
    class CreateBillingViewRequest < Struct.new(
      :name,
      :description,
      :source_views,
      :data_filter_expression,
      :client_token,
      :resource_tags)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The time when the billing view was created.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/CreateBillingViewResponse AWS API Documentation
    #
    class CreateBillingViewResponse < Struct.new(
      :arn,
      :created_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/DeleteBillingViewRequest AWS API Documentation
    #
    class DeleteBillingViewRequest < Struct.new(
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/DeleteBillingViewResponse AWS API Documentation
    #
    class DeleteBillingViewResponse < Struct.new(
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # The metadata that you can use to filter and group your results.
    #
    # @!attribute [rw] key
    #   The names of the metadata types that you can use to filter and group
    #   your results.
    #   @return [String]
    #
    # @!attribute [rw] values
    #   The metadata values that you can use to filter and group your
    #   results.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/DimensionValues AWS API Documentation
    #
    class DimensionValues < Struct.new(
      :key,
      :values)
      SENSITIVE = []
      include Aws::Structure
    end

    # See [Expression][1]. Billing view only supports `LINKED_ACCOUNT` and
    # `Tags`.
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html
    #
    # @!attribute [rw] dimensions
    #   The specific `Dimension` to use for `Expression`.
    #   @return [Types::DimensionValues]
    #
    # @!attribute [rw] tags
    #   The specific `Tag` to use for `Expression`.
    #   @return [Types::TagValues]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/Expression AWS API Documentation
    #
    class Expression < Struct.new(
      :dimensions,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/GetBillingViewRequest AWS API Documentation
    #
    class GetBillingViewRequest < Struct.new(
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] billing_view
    #   The billing view element associated with the specified ARN.
    #   @return [Types::BillingViewElement]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/GetBillingViewResponse AWS API Documentation
    #
    class GetBillingViewResponse < Struct.new(
      :billing_view)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the billing view resource to which
    #   the policy is attached to.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/GetResourcePolicyRequest AWS API Documentation
    #
    class GetResourcePolicyRequest < Struct.new(
      :resource_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the billing view resource to which
    #   the policy is attached to.
    #   @return [String]
    #
    # @!attribute [rw] policy
    #   The resource-based policy document attached to the resource in
    #   `JSON` format.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/GetResourcePolicyResponse AWS API Documentation
    #
    class GetResourcePolicyResponse < Struct.new(
      :resource_arn,
      :policy)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request processing failed because of an unknown error, exception,
    # or failure.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/InternalServerException AWS API Documentation
    #
    class InternalServerException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] active_time_range
    #   The time range for the billing views listed. `PRIMARY` billing view
    #   is always listed. `BILLING_GROUP` billing views are listed for time
    #   ranges when the associated billing group resource in Billing
    #   Conductor is active. The time range must be within one calendar
    #   month.
    #   @return [Types::ActiveTimeRange]
    #
    # @!attribute [rw] arns
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [Array<String>]
    #
    # @!attribute [rw] billing_view_types
    #   The type of billing view.
    #   @return [Array<String>]
    #
    # @!attribute [rw] owner_account_id
    #   The list of owners of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of billing views to retrieve. Default is 100.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The pagination token that is used on subsequent calls to list
    #   billing views.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListBillingViewsRequest AWS API Documentation
    #
    class ListBillingViewsRequest < Struct.new(
      :active_time_range,
      :arns,
      :billing_view_types,
      :owner_account_id,
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] billing_views
    #   A list of `BillingViewListElement` retrieved.
    #   @return [Array<Types::BillingViewListElement>]
    #
    # @!attribute [rw] next_token
    #   The pagination token to use on subsequent calls to list billing
    #   views.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListBillingViewsResponse AWS API Documentation
    #
    class ListBillingViewsResponse < Struct.new(
      :billing_views,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The number of entries a paginated response contains.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The pagination token that is used on subsequent calls to list
    #   billing views.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListSourceViewsForBillingViewRequest AWS API Documentation
    #
    class ListSourceViewsForBillingViewRequest < Struct.new(
      :arn,
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] source_views
    #   A list of billing views used as the data source for the custom
    #   billing view.
    #   @return [Array<String>]
    #
    # @!attribute [rw] next_token
    #   The pagination token that is used on subsequent calls to list
    #   billing views.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListSourceViewsForBillingViewResponse AWS API Documentation
    #
    class ListSourceViewsForBillingViewResponse < Struct.new(
      :source_views,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the resource.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListTagsForResourceRequest AWS API Documentation
    #
    class ListTagsForResourceRequest < Struct.new(
      :resource_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_tags
    #   A list of tag key value pairs that are associated with the resource.
    #   @return [Array<Types::ResourceTag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ListTagsForResourceResponse AWS API Documentation
    #
    class ListTagsForResourceResponse < Struct.new(
      :resource_tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # The specified ARN in the request doesn't exist.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   Value is a list of resource IDs that were not found.
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   Value is the type of resource that was not found.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ResourceNotFoundException AWS API Documentation
    #
    class ResourceNotFoundException < Struct.new(
      :message,
      :resource_id,
      :resource_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # The tag structure that contains a tag key and value.
    #
    # @!attribute [rw] key
    #   The key that's associated with the tag.
    #   @return [String]
    #
    # @!attribute [rw] value
    #   The value that's associated with the tag.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ResourceTag AWS API Documentation
    #
    class ResourceTag < Struct.new(
      :key,
      :value)
      SENSITIVE = []
      include Aws::Structure
    end

    # You've reached the limit of resources you can create, or exceeded the
    # size of an individual resource.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_id
    #   The ID of the resource.
    #   @return [String]
    #
    # @!attribute [rw] resource_type
    #   The type of Amazon Web Services resource.
    #   @return [String]
    #
    # @!attribute [rw] service_code
    #   The container for the `serviceCode`.
    #   @return [String]
    #
    # @!attribute [rw] quota_code
    #   The container for the `quotaCode`.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ServiceQuotaExceededException AWS API Documentation
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
    #   The Amazon Resource Name (ARN) of the resource.
    #   @return [String]
    #
    # @!attribute [rw] resource_tags
    #   A list of tag key value pairs that are associated with the resource.
    #   @return [Array<Types::ResourceTag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/TagResourceRequest AWS API Documentation
    #
    class TagResourceRequest < Struct.new(
      :resource_arn,
      :resource_tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/TagResourceResponse AWS API Documentation
    #
    class TagResourceResponse < Aws::EmptyStructure; end

    # The values that are available for a tag.
    #
    # @!attribute [rw] key
    #   The key for the tag.
    #   @return [String]
    #
    # @!attribute [rw] values
    #   The specific value of the tag.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/TagValues AWS API Documentation
    #
    class TagValues < Struct.new(
      :key,
      :values)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request was denied due to request throttling.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ThrottlingException AWS API Documentation
    #
    class ThrottlingException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the resource.
    #   @return [String]
    #
    # @!attribute [rw] resource_tag_keys
    #   A list of tag key value pairs that are associated with the resource.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/UntagResourceRequest AWS API Documentation
    #
    class UntagResourceRequest < Struct.new(
      :resource_arn,
      :resource_tag_keys)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/UntagResourceResponse AWS API Documentation
    #
    class UntagResourceResponse < Aws::EmptyStructure; end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the billing view.
    #   @return [String]
    #
    # @!attribute [rw] data_filter_expression
    #   See [Expression][1]. Billing view only supports `LINKED_ACCOUNT` and
    #   `Tags`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html
    #   @return [Types::Expression]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/UpdateBillingViewRequest AWS API Documentation
    #
    class UpdateBillingViewRequest < Struct.new(
      :arn,
      :name,
      :description,
      :data_filter_expression)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) that can be used to uniquely identify
    #   the billing view.
    #   @return [String]
    #
    # @!attribute [rw] updated_at
    #   The time when the billing view was last updated.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/UpdateBillingViewResponse AWS API Documentation
    #
    class UpdateBillingViewResponse < Struct.new(
      :arn,
      :updated_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # The input fails to satisfy the constraints specified by an Amazon Web
    # Services service.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] reason
    #   The input fails to satisfy the constraints specified by an Amazon
    #   Web Services service.
    #   @return [String]
    #
    # @!attribute [rw] field_list
    #   The input fails to satisfy the constraints specified by an Amazon
    #   Web Services service.
    #   @return [Array<Types::ValidationExceptionField>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ValidationException AWS API Documentation
    #
    class ValidationException < Struct.new(
      :message,
      :reason,
      :field_list)
      SENSITIVE = []
      include Aws::Structure
    end

    # The field's information of a request that resulted in an exception.
    #
    # @!attribute [rw] name
    #   The name of the field.
    #   @return [String]
    #
    # @!attribute [rw] message
    #   The message describing why the field failed validation.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/billing-2023-09-07/ValidationExceptionField AWS API Documentation
    #
    class ValidationExceptionField < Struct.new(
      :name,
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

  end
end

