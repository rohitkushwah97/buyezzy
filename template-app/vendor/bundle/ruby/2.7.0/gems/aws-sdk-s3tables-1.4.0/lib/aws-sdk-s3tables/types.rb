# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::S3Tables
  module Types

    # The action cannot be performed because you do not have the required
    # permission.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/AccessDeniedException AWS API Documentation
    #
    class AccessDeniedException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request is invalid or malformed.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/BadRequestException AWS API Documentation
    #
    class BadRequestException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request failed because there is a conflict with a previous write.
    # You can retry the request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ConflictException AWS API Documentation
    #
    class ConflictException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket to create the
    #   namespace in.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   A name for the namespace.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateNamespaceRequest AWS API Documentation
    #
    class CreateNamespaceRequest < Struct.new(
      :table_bucket_arn,
      :namespace)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket the namespace was
    #   created in.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateNamespaceResponse AWS API Documentation
    #
    class CreateNamespaceResponse < Struct.new(
      :table_bucket_arn,
      :namespace)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name for the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateTableBucketRequest AWS API Documentation
    #
    class CreateTableBucketRequest < Struct.new(
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateTableBucketResponse AWS API Documentation
    #
    class CreateTableBucketResponse < Struct.new(
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket to create the
    #   table in.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace to associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name for the table.
    #   @return [String]
    #
    # @!attribute [rw] format
    #   The format for the table.
    #   @return [String]
    #
    # @!attribute [rw] metadata
    #   The metadata for the table.
    #   @return [Types::TableMetadata]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateTableRequest AWS API Documentation
    #
    class CreateTableRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :format,
      :metadata)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/CreateTableResponse AWS API Documentation
    #
    class CreateTableResponse < Struct.new(
      :table_arn,
      :version_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket associated with
    #   the namespace.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/DeleteNamespaceRequest AWS API Documentation
    #
    class DeleteNamespaceRequest < Struct.new(
      :table_bucket_arn,
      :namespace)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/DeleteTableBucketPolicyRequest AWS API Documentation
    #
    class DeleteTableBucketPolicyRequest < Struct.new(
      :table_bucket_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/DeleteTableBucketRequest AWS API Documentation
    #
    class DeleteTableBucketRequest < Struct.new(
      :table_bucket_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket that contains the
    #   table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The table name.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/DeleteTablePolicyRequest AWS API Documentation
    #
    class DeleteTablePolicyRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket that contains the
    #   table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/DeleteTableRequest AWS API Documentation
    #
    class DeleteTableRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :version_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # The caller isn't authorized to make the request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ForbiddenException AWS API Documentation
    #
    class ForbiddenException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetNamespaceRequest AWS API Documentation
    #
    class GetNamespaceRequest < Struct.new(
      :table_bucket_arn,
      :namespace)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   The date and time the namespace was created at.
    #   @return [Time]
    #
    # @!attribute [rw] created_by
    #   The ID of the account that created the namespace.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The ID of the account that owns the namespcace.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetNamespaceResponse AWS API Documentation
    #
    class GetNamespaceResponse < Struct.new(
      :namespace,
      :created_at,
      :created_by,
      :owner_account_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket associated with
    #   the maintenance configuration.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketMaintenanceConfigurationRequest AWS API Documentation
    #
    class GetTableBucketMaintenanceConfigurationRequest < Struct.new(
      :table_bucket_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket associated with
    #   the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] configuration
    #   Details about the maintenance configuration for the table bucket.
    #   @return [Hash<String,Types::TableBucketMaintenanceConfigurationValue>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketMaintenanceConfigurationResponse AWS API Documentation
    #
    class GetTableBucketMaintenanceConfigurationResponse < Struct.new(
      :table_bucket_arn,
      :configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketPolicyRequest AWS API Documentation
    #
    class GetTableBucketPolicyRequest < Struct.new(
      :table_bucket_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_policy
    #   The `JSON` that defines the policy.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketPolicyResponse AWS API Documentation
    #
    class GetTableBucketPolicyResponse < Struct.new(
      :resource_policy)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketRequest AWS API Documentation
    #
    class GetTableBucketRequest < Struct.new(
      :table_bucket_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table bucket
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The ID of the account that owns the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The date and time the table bucket was created.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableBucketResponse AWS API Documentation
    #
    class GetTableBucketResponse < Struct.new(
      :arn,
      :name,
      :owner_account_id,
      :created_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMaintenanceConfigurationRequest AWS API Documentation
    #
    class GetTableMaintenanceConfigurationRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] configuration
    #   Details about the maintenance configuration for the table bucket.
    #   @return [Hash<String,Types::TableMaintenanceConfigurationValue>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMaintenanceConfigurationResponse AWS API Documentation
    #
    class GetTableMaintenanceConfigurationResponse < Struct.new(
      :table_arn,
      :configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The name of the namespace the table is associated with.     </p>
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the maintenance job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMaintenanceJobStatusRequest AWS API Documentation
    #
    class GetTableMaintenanceJobStatusRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the maintenance job.
    #   @return [Hash<String,Types::TableMaintenanceJobStatusValue>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMaintenanceJobStatusResponse AWS API Documentation
    #
    class GetTableMaintenanceJobStatusResponse < Struct.new(
      :table_arn,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace of the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMetadataLocationRequest AWS API Documentation
    #
    class GetTableMetadataLocationRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] version_token
    #   The version token.
    #   @return [String]
    #
    # @!attribute [rw] metadata_location
    #   The metadata location.
    #   @return [String]
    #
    # @!attribute [rw] warehouse_location
    #   The warehouse location.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableMetadataLocationResponse AWS API Documentation
    #
    class GetTableMetadataLocationResponse < Struct.new(
      :version_token,
      :metadata_location,
      :warehouse_location)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket that contains the
    #   table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTablePolicyRequest AWS API Documentation
    #
    class GetTablePolicyRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_policy
    #   The `JSON` that defines the policy.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTablePolicyResponse AWS API Documentation
    #
    class GetTablePolicyResponse < Struct.new(
      :resource_policy)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket associated with
    #   the table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The name of the namespace the table is associated with.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableRequest AWS API Documentation
    #
    class GetTableRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the table.
    #   @return [String]
    #
    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [Array<String>]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @!attribute [rw] metadata_location
    #   The metadata location of the table.
    #   @return [String]
    #
    # @!attribute [rw] warehouse_location
    #   The warehouse location of the table.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The date and time the table bucket was created at.
    #   @return [Time]
    #
    # @!attribute [rw] created_by
    #   The ID of the account that created the table.
    #   @return [String]
    #
    # @!attribute [rw] managed_by_service
    #   The service that manages the table.
    #   @return [String]
    #
    # @!attribute [rw] modified_at
    #   The date and time the table was last modified on.
    #   @return [Time]
    #
    # @!attribute [rw] modified_by
    #   The ID of the account that last modified the table.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The ID of the account that owns the table.
    #   @return [String]
    #
    # @!attribute [rw] format
    #   The format of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/GetTableResponse AWS API Documentation
    #
    class GetTableResponse < Struct.new(
      :name,
      :type,
      :table_arn,
      :namespace,
      :version_token,
      :metadata_location,
      :warehouse_location,
      :created_at,
      :created_by,
      :managed_by_service,
      :modified_at,
      :modified_by,
      :owner_account_id,
      :format)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the compaction settings for an Iceberg table.
    #
    # @!attribute [rw] target_file_size_mb
    #   The target file size for the table in MB.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/IcebergCompactionSettings AWS API Documentation
    #
    class IcebergCompactionSettings < Struct.new(
      :target_file_size_mb)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the metadata for an Iceberg table.
    #
    # @!attribute [rw] schema
    #   The schema for an Iceberg table.
    #   @return [Types::IcebergSchema]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/IcebergMetadata AWS API Documentation
    #
    class IcebergMetadata < Struct.new(
      :schema)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the schema for an Iceberg table.
    #
    # @!attribute [rw] fields
    #   The schema fields for the table
    #   @return [Array<Types::SchemaField>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/IcebergSchema AWS API Documentation
    #
    class IcebergSchema < Struct.new(
      :fields)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the snapshot management settings for an Iceberg
    # table. The oldest snapshot expires when its age exceeds the
    # `maxSnapshotAgeHours` and the total number of snapshots exceeds the
    # value for the minimum number of snapshots to keep
    # `minSnapshotsToKeep`.
    #
    # @!attribute [rw] min_snapshots_to_keep
    #   The minimum number of snapshots to keep.
    #   @return [Integer]
    #
    # @!attribute [rw] max_snapshot_age_hours
    #   The maximum age of a snapshot before it can be expired.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/IcebergSnapshotManagementSettings AWS API Documentation
    #
    class IcebergSnapshotManagementSettings < Struct.new(
      :min_snapshots_to_keep,
      :max_snapshot_age_hours)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the unreferenced file removal settings for an
    # Iceberg table bucket.
    #
    # @!attribute [rw] unreferenced_days
    #   The number of days an object has to be unreferenced before it is
    #   marked as non-current.      </p>
    #   @return [Integer]
    #
    # @!attribute [rw] non_current_days
    #   The number of days an object has to be non-current before it is
    #   deleted.     </p>
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/IcebergUnreferencedFileRemovalSettings AWS API Documentation
    #
    class IcebergUnreferencedFileRemovalSettings < Struct.new(
      :unreferenced_days,
      :non_current_days)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request failed due to an internal server error.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/InternalServerErrorException AWS API Documentation
    #
    class InternalServerErrorException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] prefix
    #   The prefix of the namespaces.
    #   @return [String]
    #
    # @!attribute [rw] continuation_token
    #   `ContinuationToken` indicates to Amazon S3 that the list is being
    #   continued on this bucket with a token. `ContinuationToken` is
    #   obfuscated and is not a real key. You can use this
    #   `ContinuationToken` for pagination of the list results.
    #   @return [String]
    #
    # @!attribute [rw] max_namespaces
    #   The maximum number of namespaces to return in the list.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListNamespacesRequest AWS API Documentation
    #
    class ListNamespacesRequest < Struct.new(
      :table_bucket_arn,
      :prefix,
      :continuation_token,
      :max_namespaces)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] namespaces
    #   A list of namespaces.
    #   @return [Array<Types::NamespaceSummary>]
    #
    # @!attribute [rw] continuation_token
    #   The `ContinuationToken` for pagination of the list results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListNamespacesResponse AWS API Documentation
    #
    class ListNamespacesResponse < Struct.new(
      :namespaces,
      :continuation_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] prefix
    #   The prefix of the table buckets.
    #   @return [String]
    #
    # @!attribute [rw] continuation_token
    #   `ContinuationToken` indicates to Amazon S3 that the list is being
    #   continued on this bucket with a token. `ContinuationToken` is
    #   obfuscated and is not a real key. You can use this
    #   `ContinuationToken` for pagination of the list results.
    #   @return [String]
    #
    # @!attribute [rw] max_buckets
    #   The maximum number of table buckets to return in the list.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListTableBucketsRequest AWS API Documentation
    #
    class ListTableBucketsRequest < Struct.new(
      :prefix,
      :continuation_token,
      :max_buckets)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_buckets
    #   A list of table buckets.
    #   @return [Array<Types::TableBucketSummary>]
    #
    # @!attribute [rw] continuation_token
    #   You can use this `ContinuationToken` for pagination of the list
    #   results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListTableBucketsResponse AWS API Documentation
    #
    class ListTableBucketsResponse < Struct.new(
      :table_buckets,
      :continuation_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace of the tables.
    #   @return [String]
    #
    # @!attribute [rw] prefix
    #   The prefix of the tables.
    #   @return [String]
    #
    # @!attribute [rw] continuation_token
    #   `ContinuationToken` indicates to Amazon S3 that the list is being
    #   continued on this bucket with a token. `ContinuationToken` is
    #   obfuscated and is not a real key. You can use this
    #   `ContinuationToken` for pagination of the list results.
    #   @return [String]
    #
    # @!attribute [rw] max_tables
    #   The maximum number of tables to return.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListTablesRequest AWS API Documentation
    #
    class ListTablesRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :prefix,
      :continuation_token,
      :max_tables)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] tables
    #   A list of tables.
    #   @return [Array<Types::TableSummary>]
    #
    # @!attribute [rw] continuation_token
    #   You can use this `ContinuationToken` for pagination of the list
    #   results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/ListTablesResponse AWS API Documentation
    #
    class ListTablesResponse < Struct.new(
      :tables,
      :continuation_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about a namespace.
    #
    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   The date and time the namespace was created at.
    #   @return [Time]
    #
    # @!attribute [rw] created_by
    #   The ID of the account that created the namespace.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The ID of the account that owns the namespace.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/NamespaceSummary AWS API Documentation
    #
    class NamespaceSummary < Struct.new(
      :namespace,
      :created_at,
      :created_by,
      :owner_account_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request was rejected because the specified resource could not be
    # found.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/NotFoundException AWS API Documentation
    #
    class NotFoundException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket associated with
    #   the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] value
    #   Defines the values of the maintenance configuration for the table
    #   bucket.
    #   @return [Types::TableBucketMaintenanceConfigurationValue]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/PutTableBucketMaintenanceConfigurationRequest AWS API Documentation
    #
    class PutTableBucketMaintenanceConfigurationRequest < Struct.new(
      :table_bucket_arn,
      :type,
      :value)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] resource_policy
    #   The `JSON` that defines the policy.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/PutTableBucketPolicyRequest AWS API Documentation
    #
    class PutTableBucketPolicyRequest < Struct.new(
      :table_bucket_arn,
      :resource_policy)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table associated with the
    #   maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace of the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] value
    #   Defines the values of the maintenance configuration for the table.
    #   @return [Types::TableMaintenanceConfigurationValue]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/PutTableMaintenanceConfigurationRequest AWS API Documentation
    #
    class PutTableMaintenanceConfigurationRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :type,
      :value)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket that contains the
    #   table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] resource_policy
    #   The `JSON` that defines the policy.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/PutTablePolicyRequest AWS API Documentation
    #
    class PutTablePolicyRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :resource_policy)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace associated with the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The current name of the table.
    #   @return [String]
    #
    # @!attribute [rw] new_namespace_name
    #   The new name for the namespace.
    #   @return [String]
    #
    # @!attribute [rw] new_name
    #   The new name for the table.
    #   @return [String]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/RenameTableRequest AWS API Documentation
    #
    class RenameTableRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :new_namespace_name,
      :new_name,
      :version_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about a schema field.
    #
    # @!attribute [rw] name
    #   The name of the field.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The field type. S3 Tables supports all Apache Iceberg primitive
    #   types. For more information, see the [Apache Iceberg
    #   documentation][1].
    #
    #
    #
    #   [1]: https://iceberg.apache.org/spec/#primitive-types
    #   @return [String]
    #
    # @!attribute [rw] required
    #   A Boolean value that specifies whether values are required for each
    #   row in this field. By default, this is `false` and null values are
    #   allowed in the field. If this is `true` the field does not allow
    #   null values.
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/SchemaField AWS API Documentation
    #
    class SchemaField < Struct.new(
      :name,
      :type,
      :required)
      SENSITIVE = []
      include Aws::Structure
    end

    # Details about the values that define the maintenance configuration for
    # a table bucket.
    #
    # @!attribute [rw] status
    #   The status of the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] settings
    #   Contains details about the settings of the maintenance
    #   configuration.
    #   @return [Types::TableBucketMaintenanceSettings]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableBucketMaintenanceConfigurationValue AWS API Documentation
    #
    class TableBucketMaintenanceConfigurationValue < Struct.new(
      :status,
      :settings)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the maintenance settings for the table bucket.
    #
    # @note TableBucketMaintenanceSettings is a union - when making an API calls you must set exactly one of the members.
    #
    # @note TableBucketMaintenanceSettings is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of TableBucketMaintenanceSettings corresponding to the set member.
    #
    # @!attribute [rw] iceberg_unreferenced_file_removal
    #   The unreferenced file removal settings for the table bucket.
    #   @return [Types::IcebergUnreferencedFileRemovalSettings]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableBucketMaintenanceSettings AWS API Documentation
    #
    class TableBucketMaintenanceSettings < Struct.new(
      :iceberg_unreferenced_file_removal,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class IcebergUnreferencedFileRemoval < TableBucketMaintenanceSettings; end
      class Unknown < TableBucketMaintenanceSettings; end
    end

    # Contains details about a table bucket.
    #
    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The ID of the account that owns the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The date and time the table bucket was created at.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableBucketSummary AWS API Documentation
    #
    class TableBucketSummary < Struct.new(
      :arn,
      :name,
      :owner_account_id,
      :created_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains the values that define a maintenance configuration for a
    # table.
    #
    # @!attribute [rw] status
    #   The status of the maintenance configuration.
    #   @return [String]
    #
    # @!attribute [rw] settings
    #   Contains details about the settings for the maintenance
    #   configuration.
    #   @return [Types::TableMaintenanceSettings]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableMaintenanceConfigurationValue AWS API Documentation
    #
    class TableMaintenanceConfigurationValue < Struct.new(
      :status,
      :settings)
      SENSITIVE = []
      include Aws::Structure
    end

    # Details about the status of a maintenance job.
    #
    # @!attribute [rw] status
    #   The status of the job.
    #   @return [String]
    #
    # @!attribute [rw] last_run_timestamp
    #   The date and time that the maintenance job was last run.
    #   @return [Time]
    #
    # @!attribute [rw] failure_message
    #   The failure message of a failed job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableMaintenanceJobStatusValue AWS API Documentation
    #
    class TableMaintenanceJobStatusValue < Struct.new(
      :status,
      :last_run_timestamp,
      :failure_message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about maintenance settings for the table.
    #
    # @note TableMaintenanceSettings is a union - when making an API calls you must set exactly one of the members.
    #
    # @note TableMaintenanceSettings is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of TableMaintenanceSettings corresponding to the set member.
    #
    # @!attribute [rw] iceberg_compaction
    #   Contains details about the Iceberg compaction settings for the
    #   table.
    #   @return [Types::IcebergCompactionSettings]
    #
    # @!attribute [rw] iceberg_snapshot_management
    #   Contains details about the Iceberg snapshot management settings for
    #   the table.
    #   @return [Types::IcebergSnapshotManagementSettings]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableMaintenanceSettings AWS API Documentation
    #
    class TableMaintenanceSettings < Struct.new(
      :iceberg_compaction,
      :iceberg_snapshot_management,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class IcebergCompaction < TableMaintenanceSettings; end
      class IcebergSnapshotManagement < TableMaintenanceSettings; end
      class Unknown < TableMaintenanceSettings; end
    end

    # Contains details about the table metadata.
    #
    # @note TableMetadata is a union - when making an API calls you must set exactly one of the members.
    #
    # @!attribute [rw] iceberg
    #   Contains details about the metadata of an Iceberg table.
    #   @return [Types::IcebergMetadata]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableMetadata AWS API Documentation
    #
    class TableMetadata < Struct.new(
      :iceberg,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class Iceberg < TableMetadata; end
      class Unknown < TableMetadata; end
    end

    # Contains details about a table.
    #
    # @!attribute [rw] namespace
    #   The name of the namespace.
    #   @return [Array<String>]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the table.
    #   @return [String]
    #
    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The date and time the table was created at.
    #   @return [Time]
    #
    # @!attribute [rw] modified_at
    #   The date and time the table was last modified at.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TableSummary AWS API Documentation
    #
    class TableSummary < Struct.new(
      :namespace,
      :name,
      :type,
      :table_arn,
      :created_at,
      :modified_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # The limit on the number of requests per second was exceeded.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/TooManyRequestsException AWS API Documentation
    #
    class TooManyRequestsException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] table_bucket_arn
    #   The Amazon Resource Name (ARN) of the table bucket.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace of the table.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @!attribute [rw] metadata_location
    #   The new metadata location for the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/UpdateTableMetadataLocationRequest AWS API Documentation
    #
    class UpdateTableMetadataLocationRequest < Struct.new(
      :table_bucket_arn,
      :namespace,
      :name,
      :version_token,
      :metadata_location)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name of the table.
    #   @return [String]
    #
    # @!attribute [rw] table_arn
    #   The Amazon Resource Name (ARN) of the table.
    #   @return [String]
    #
    # @!attribute [rw] namespace
    #   The namespace the table is associated with.
    #   @return [Array<String>]
    #
    # @!attribute [rw] version_token
    #   The version token of the table.
    #   @return [String]
    #
    # @!attribute [rw] metadata_location
    #   The metadata location of the table.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/s3tables-2018-05-10/UpdateTableMetadataLocationResponse AWS API Documentation
    #
    class UpdateTableMetadataLocationResponse < Struct.new(
      :name,
      :table_arn,
      :namespace,
      :version_token,
      :metadata_location)
      SENSITIVE = []
      include Aws::Structure
    end

  end
end

