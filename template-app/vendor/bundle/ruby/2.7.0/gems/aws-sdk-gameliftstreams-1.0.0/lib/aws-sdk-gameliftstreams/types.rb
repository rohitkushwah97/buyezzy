# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::GameLiftStreams
  module Types

    # You don't have the required permissions to access this Amazon
    # GameLift Streams resource. Correct the permissions before you try
    # again.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/AccessDeniedException AWS API Documentation
    #
    class AccessDeniedException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   A stream group to add the specified locations to.
    #
    #   This value is a Amazon Resource Name (ARN) that uniquely identifies
    #   the stream group resource. Format example: `1AB2C3De4`.
    #   @return [String]
    #
    # @!attribute [rw] location_configurations
    #   A set of one or more locations and the streaming capacity for each
    #   location.
    #   @return [Array<Types::LocationConfiguration>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/AddStreamGroupLocationsInput AWS API Documentation
    #
    class AddStreamGroupLocationsInput < Struct.new(
      :identifier,
      :location_configurations)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   This value is the Amazon Resource Name (ARN) that uniquely
    #   identifies the stream group resource. Format example: `1AB2C3De4`.
    #   @return [String]
    #
    # @!attribute [rw] locations
    #   This value is set of locations, including their name, current
    #   status, and capacities.
    #
    #   A location can be in one of the following states:
    #
    #   * **ACTIVATING**: Amazon GameLift Streams is preparing the location.
    #     You cannot stream from, scale the capacity of, or remove this
    #     location yet.
    #
    #   * **ACTIVE**: The location is provisioned with initial capacity. You
    #     can now stream from, scale the capacity of, or remove this
    #     location.
    #
    #   * **ERROR**: Amazon GameLift Streams failed to set up this location.
    #     The StatusReason field describes the error. You can remove this
    #     location and try to add it again.
    #
    #   * **REMOVING**: Amazon GameLift Streams is working to remove this
    #     location. It releases all provisioned capacity for this location
    #     in this stream group.
    #   @return [Array<Types::LocationState>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/AddStreamGroupLocationsOutput AWS API Documentation
    #
    class AddStreamGroupLocationsOutput < Struct.new(
      :identifier,
      :locations)
      SENSITIVE = []
      include Aws::Structure
    end

    # Describes an application resource that represents a collection of
    # content for streaming with Amazon GameLift Streams. To retrieve
    # additional application details, call GetApplication.
    #
    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that's assigned to an application
    #   resource and uniquely identifies the application across all Amazon
    #   Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    #   Region]:[AWS account]:application/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application. You can edit this value.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] runtime_environment
    #   A set of configuration settings to run the application on a stream
    #   group. This configures the operating system, and can include
    #   compatibility layers and other drivers.
    #
    #   A runtime environment can be one of the following:
    #
    #   * For Linux applications
    #
    #     * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #     ^
    #   * For Windows applications
    #
    #     * Microsoft Windows Server 2022 Base (`Type=WINDOWS,
    #       Version=2022`)
    #
    #     * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #     * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #   @return [Types::RuntimeEnvironment]
    #
    # @!attribute [rw] status
    #   The current status of the application resource. Possible statuses
    #   include the following:
    #
    #   * `INITIALIZED`: Amazon GameLift Streams has received the request
    #     and is initiating the work flow to create an application.
    #
    #   * `PROCESSING`: The create application work flow is in process.
    #     Amazon GameLift Streams is copying the content and caching for
    #     future deployment in a stream group.
    #
    #   * `READY`: The application is ready to deploy in a stream group.
    #
    #   * `ERROR`: An error occurred when setting up the application. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the application.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ApplicationSummary AWS API Documentation
    #
    class ApplicationSummary < Struct.new(
      :arn,
      :created_at,
      :description,
      :id,
      :last_updated_at,
      :runtime_environment,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_identifiers
    #   A set of applications to associate with the stream group.
    #
    #   This value is a set of either [Amazon Resource Names (ARN)][1] or
    #   IDs that uniquely identify application resources. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] identifier
    #   A stream group to associate to the applications.
    #
    #   This value is a [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/AssociateApplicationsInput AWS API Documentation
    #
    class AssociateApplicationsInput < Struct.new(
      :application_identifiers,
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_arns
    #   A set of applications that are associated to the stream group.
    #
    #   This value is a set of either [Amazon Resource Names (ARN)][1] or
    #   IDs that uniquely identify application resources. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] arn
    #   A stream group that is associated to the applications.
    #
    #   This value is a [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/AssociateApplicationsOutput AWS API Documentation
    #
    class AssociateApplicationsOutput < Struct.new(
      :application_arns,
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # The requested operation would cause a conflict with the current state
    # of a service resource associated with the request. Resolve the
    # conflict before retrying this request.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ConflictException AWS API Documentation
    #
    class ConflictException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_log_output_uri
    #   An Amazon S3 URI to a bucket where you would like Amazon GameLift
    #   Streams to save application logs. Use the following format for the
    #   URI: `s3://[bucket name]/[prefix]`. Required if you specify one or
    #   more `LogPaths`.
    #
    #   <note markdown="1"> The log bucket must have permissions that give Amazon GameLift
    #   Streams access to write the log files. For more information, see
    #   **Getting Started** in the Amazon GameLift Streams Developer Guide.
    #
    #    </note>
    #   @return [String]
    #
    # @!attribute [rw] application_log_paths
    #   Locations of log files that your content generates during a stream
    #   session. Enter path values that are relative to the
    #   `ApplicationSourceUri` location. You can specify up to 10 log
    #   locations. Amazon GameLift Streams uploads designated log files to
    #   the Amazon S3 bucket that you specify in `ApplicationLogOutputUri`
    #   at the end of a stream session. To retrieve stored log files, call
    #   GetStreamSession and get the `LogFileLocationUri`.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_source_uri
    #   The location of the content that you want to stream. Enter the URI
    #   of an Amazon S3 location (bucket name and prefixes) that contains
    #   your content. Use the following format for the URI: `s3://[bucket
    #   name]/[prefix]`. The location can have a multi-level prefix
    #   structure, but it must include all the files needed to run the
    #   content. Amazon GameLift Streams copies everything under the
    #   specified location.
    #
    #   This value is immutable. To designate a different content location,
    #   create a new application.
    #
    #   <note markdown="1"> The S3 bucket and the Amazon GameLift Streams application must be in
    #   the same Amazon Web Services Region.
    #
    #    </note>
    #   @return [String]
    #
    # @!attribute [rw] client_token
    #   A unique identifier that represents a client request. The request is
    #   idempotent, which ensures that an API request completes only once.
    #   When users send a request, Amazon GameLift Streams automatically
    #   populates this field.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application. You can update this
    #   value later.
    #   @return [String]
    #
    # @!attribute [rw] executable_path
    #   The path and file name of the executable file that launches the
    #   content for streaming. Enter a path value that is relative to the
    #   location set in `ApplicationSourceUri`.
    #   @return [String]
    #
    # @!attribute [rw] runtime_environment
    #   A set of configuration settings to run the application on a stream
    #   group. This configures the operating system, and can include
    #   compatibility layers and other drivers.
    #
    #   A runtime environment can be one of the following:
    #
    #   * For Linux applications
    #
    #     * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #     ^
    #   * For Windows applications
    #
    #     * Microsoft Windows Server 2022 Base (`Type=WINDOWS,
    #       Version=2022`)
    #
    #     * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #     * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #   @return [Types::RuntimeEnvironment]
    #
    # @!attribute [rw] tags
    #   A list of labels to assign to the new application resource. Tags are
    #   developer-defined key-value pairs. Tagging Amazon Web Services
    #   resources is useful for resource management, access management and
    #   cost allocation. See [ Tagging Amazon Web Services Resources][1] in
    #   the *Amazon Web Services General Reference*. You can use TagResource
    #   to add tags, UntagResource to remove tags, and ListTagsForResource
    #   to view tags on existing resources. The maximum tag limit might be
    #   lower than stated. See the *Amazon Web Services General Reference*
    #   for actual tagging limits.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateApplicationInput AWS API Documentation
    #
    class CreateApplicationInput < Struct.new(
      :application_log_output_uri,
      :application_log_paths,
      :application_source_uri,
      :client_token,
      :description,
      :executable_path,
      :runtime_environment,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_log_output_uri
    #   An Amazon S3 URI to a bucket where you would like Amazon GameLift
    #   Streams to save application logs. Use the following format for the
    #   URI: `s3://[bucket name]/[prefix]`. Required if you specify one or
    #   more `LogPaths`.
    #   @return [String]
    #
    # @!attribute [rw] application_log_paths
    #   Locations of log files that your content generates during a stream
    #   session. Amazon GameLift Streams uploads log files to the Amazon S3
    #   bucket that you specify in `ApplicationLogOutputUri` at the end of a
    #   stream session. To retrieve stored log files, call GetStreamSession
    #   and get the `LogFileLocationUri`.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_source_uri
    #   The original Amazon S3 location of uploaded stream content for the
    #   application.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that's assigned to an application
    #   resource and uniquely identifies it across all Amazon Web Services
    #   Regions. Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    #   account]:application/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_stream_groups
    #   A newly created application is not associated to any stream groups.
    #   This value is empty.
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application. You can edit this value.
    #   @return [String]
    #
    # @!attribute [rw] executable_path
    #   The path and file name of the executable file that launches the
    #   content for streaming.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] replication_statuses
    #   A set of replication statuses for each location.
    #   @return [Array<Types::ReplicationStatus>]
    #
    # @!attribute [rw] runtime_environment
    #   A set of configuration settings to run the application on a stream
    #   group. This configures the operating system, and can include
    #   compatibility layers and other drivers.
    #
    #   A runtime environment can be one of the following:
    #
    #   * For Linux applications
    #
    #     * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #     ^
    #   * For Windows applications
    #
    #     * Microsoft Windows Server 2022 Base (`Type=WINDOWS,
    #       Version=2022`)
    #
    #     * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #     * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #   @return [Types::RuntimeEnvironment]
    #
    # @!attribute [rw] status
    #   The current status of the application resource. Possible statuses
    #   include the following:
    #
    #   * `INITIALIZED`: Amazon GameLift Streams has received the request
    #     and is initiating the work flow to create an application.
    #
    #   * `PROCESSING`: The create application work flow is in process.
    #     Amazon GameLift Streams is copying the content and caching for
    #     future deployment in a stream group.
    #
    #   * `READY`: The application is ready to deploy in a stream group.
    #
    #   * `ERROR`: An error occurred when setting up the application. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the application.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the status reason when the application is in
    #   `ERROR` status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateApplicationOutput AWS API Documentation
    #
    class CreateApplicationOutput < Struct.new(
      :application_log_output_uri,
      :application_log_paths,
      :application_source_uri,
      :arn,
      :associated_stream_groups,
      :created_at,
      :description,
      :executable_path,
      :id,
      :last_updated_at,
      :replication_statuses,
      :runtime_environment,
      :status,
      :status_reason)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] client_token
    #   A unique identifier that represents a client request. The request is
    #   idempotent, which ensures that an API request completes only once.
    #   When users send a request, Amazon GameLift Streams automatically
    #   populates this field.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] default_application_identifier
    #   The unique identifier of the Amazon GameLift Streams application
    #   that you want to associate to a stream group as the default
    #   application. The application must be in `READY` status. By setting
    #   the default application identifier, you will optimize startup
    #   performance of this application in your stream group. Once set, this
    #   application cannot be disassociated from the stream group, unlike
    #   applications that are associated using AssociateApplications. If not
    #   set when creating a stream group, you will need to call
    #   AssociateApplications later, before you can start streaming.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] location_configurations
    #   A set of one or more locations and the streaming capacity for each
    #   location.
    #   @return [Array<Types::LocationConfiguration>]
    #
    # @!attribute [rw] stream_class
    #   The target stream quality for sessions that are hosted in this
    #   stream group. Set a stream class that is appropriate to the type of
    #   content that you're streaming. Stream class determines the type of
    #   computing resources Amazon GameLift Streams uses and impacts the
    #   cost of streaming. The following options are available:
    #
    #   A stream class can be one of the following:
    #
    #   * <b> <code>gen5n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.x builds, 32-bit
    #     applications, and anti-cheat technology. Uses NVIDIA A10G Tensor
    #     GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen5n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen5n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Uses
    #     dedicated NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.2 and 5.3 builds,
    #     32-bit applications, and anti-cheat technology. Uses NVIDIA T4
    #     Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen4n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with high 3D scene complexity. Uses dedicated NVIDIA
    #     T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   A list of labels to assign to the new stream group resource. Tags
    #   are developer-defined key-value pairs. It is useful to tag Amazon
    #   Web Services resources for resource management, access management,
    #   and cost allocation. See [ Tagging Amazon Web Services Resources][1]
    #   in the *Amazon Web Services General Reference*. You can use
    #   TagResource, UntagResource, and ListTagsForResource to add, remove,
    #   and view tags on existing resources. The maximum tag limit might be
    #   lower than stated. See the <i>Amazon Web Services </i> for actual
    #   tagging limits.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateStreamGroupInput AWS API Documentation
    #
    class CreateStreamGroupInput < Struct.new(
      :client_token,
      :default_application_identifier,
      :description,
      :location_configurations,
      :stream_class,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that is assigned to the stream group
    #   resource and that uniquely identifies the group across all Amazon
    #   Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    #   Region]:[AWS account]:streamgroup/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_applications
    #   A set of applications that this stream group is associated to. You
    #   can stream any of these applications by using this stream group.
    #
    #   This value is a set of [Amazon Resource Names (ARNs)][1] that
    #   uniquely identify application resources. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] default_application
    #   The Amazon GameLift Streams application that is associated with this
    #   stream group.
    #   @return [Types::DefaultApplication]
    #
    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   A unique ID value that is assigned to the resource when it's
    #   created. Format example: `1AB2C3De4`.
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location_states
    #   This value is the set of locations, including their name, current
    #   status, and capacities.
    #
    #   A location can be in one of the following states:
    #
    #   * **ACTIVATING**: Amazon GameLift Streams is preparing the location.
    #     You cannot stream from, scale the capacity of, or remove this
    #     location yet.
    #
    #   * **ACTIVE**: The location is provisioned with initial capacity. You
    #     can now stream from, scale the capacity of, or remove this
    #     location.
    #
    #   * **ERROR**: Amazon GameLift Streams failed to set up this location.
    #     The StatusReason field describes the error. You can remove this
    #     location and try to add it again.
    #
    #   * **REMOVING**: Amazon GameLift Streams is working to remove this
    #     location. It releases all provisioned capacity for this location
    #     in this stream group.
    #   @return [Array<Types::LocationState>]
    #
    # @!attribute [rw] status
    #   The current status of the stream group resource. Possible statuses
    #   include the following:
    #
    #   * `ACTIVATING`: The stream group is deploying and isn't ready to
    #     host streams.
    #
    #   * `ACTIVE`: The stream group is ready to host streams.
    #
    #   * `ACTIVE_WITH_ERRORS`: One or more locations in the stream group
    #     are in an error state. Verify the details of individual locations
    #     and remove any locations which are in error.
    #
    #   * `ERROR`: An error occurred when the stream group deployed. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the stream group.
    #
    #   * `UPDATING_LOCATIONS`: One or more locations in the stream group
    #     are in the process of updating (either activating or deleting).
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason that the stream group is in
    #   `ERROR` status. The possible reasons can be one of the following:
    #
    #   * `internalError`: The request can't process right now bcause of an
    #     issue with the server. Try again later. Reach out to the Amazon
    #     GameLift Streams team for more help.
    #
    #   * `noAvailableInstances`: Amazon GameLift Streams does not currently
    #     have enough available On-Demand capacity to fulfill your request.
    #     Wait a few minutes and retry the request as capacity can shift
    #     frequently. You can also try to make the request using a different
    #     stream class or in another region.
    #   @return [String]
    #
    # @!attribute [rw] stream_class
    #   The target stream quality for the stream group.
    #
    #   A stream class can be one of the following:
    #
    #   * <b> <code>gen5n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.x builds, 32-bit
    #     applications, and anti-cheat technology. Uses NVIDIA A10G Tensor
    #     GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen5n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen5n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Uses
    #     dedicated NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.2 and 5.3 builds,
    #     32-bit applications, and anti-cheat technology. Uses NVIDIA T4
    #     Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen4n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with high 3D scene complexity. Uses dedicated NVIDIA
    #     T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateStreamGroupOutput AWS API Documentation
    #
    class CreateStreamGroupOutput < Struct.new(
      :arn,
      :associated_applications,
      :created_at,
      :default_application,
      :description,
      :id,
      :last_updated_at,
      :location_states,
      :status,
      :status_reason,
      :stream_class)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] client_token
    #   A unique identifier that represents a client request. The request is
    #   idempotent, which ensures that an API request completes only once.
    #   When users send a request, Amazon GameLift Streams automatically
    #   populates this field.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] identifier
    #   [Amazon Resource Name (ARN)][1] or ID that uniquely identifies the
    #   stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #   The stream group that you want to run this stream session with. The
    #   stream group must be in `ACTIVE` status and have idle stream
    #   capacity.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] signal_request
    #   A WebRTC ICE offer string to use when initializing a WebRTC
    #   connection. The offer is a very long JSON string. Provide the string
    #   as a text value in quotes. The offer must be newly generated, not
    #   the same offer provided to `StartStreamSession`.
    #   @return [String]
    #
    # @!attribute [rw] stream_session_identifier
    #   [Amazon Resource Name (ARN)][1] that uniquely identifies the stream
    #   session resource. Format example: `1AB2C3De4`. The stream session
    #   must be in `PENDING_CLIENT_RECONNECTION` or `ACTIVE` status.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateStreamSessionConnectionInput AWS API Documentation
    #
    class CreateStreamSessionConnectionInput < Struct.new(
      :client_token,
      :identifier,
      :signal_request,
      :stream_session_identifier)
      SENSITIVE = [:signal_request]
      include Aws::Structure
    end

    # @!attribute [rw] signal_response
    #   The WebRTC answer string that the stream server generates in
    #   response to the `SignalRequest`.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/CreateStreamSessionConnectionOutput AWS API Documentation
    #
    class CreateStreamSessionConnectionOutput < Struct.new(
      :signal_response)
      SENSITIVE = [:signal_response]
      include Aws::Structure
    end

    # Represents the Amazon GameLift Streams application that a stream group
    # hosts.
    #
    # @!attribute [rw] arn
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] id
    #   The default application of the stream group.
    #
    #   This value is an [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/DefaultApplication AWS API Documentation
    #
    class DefaultApplication < Struct.new(
      :arn,
      :id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/DeleteApplicationInput AWS API Documentation
    #
    class DeleteApplicationInput < Struct.new(
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The unique ID value of the stream group resource to delete. Format
    #   example: `1AB2C3De4`.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/DeleteStreamGroupInput AWS API Documentation
    #
    class DeleteStreamGroupInput < Struct.new(
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_identifiers
    #   A set of applications that you want to disassociate from the stream
    #   group.
    #
    #   This value is a set of either [Amazon Resource Names (ARN)][1] or
    #   IDs that uniquely identify application resources. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] identifier
    #   A stream group to disassociate these applications from.
    #
    #   This value is an [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/DisassociateApplicationsInput AWS API Documentation
    #
    class DisassociateApplicationsInput < Struct.new(
      :application_identifiers,
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_arns
    #   A set of applications that are disassociated from this stream group.
    #
    #   This value is a set of either [Amazon Resource Names (ARN)][1] or
    #   IDs that uniquely identify application resources. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] arn
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/DisassociateApplicationsOutput AWS API Documentation
    #
    class DisassociateApplicationsOutput < Struct.new(
      :application_arns,
      :arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # Provides details about the stream session's exported files.
    #
    # @!attribute [rw] output_uri
    #   The S3 bucket URI where Amazon GameLift Streams uploaded the set of
    #   compressed exported files for a stream session. Amazon GameLift
    #   Streams generates a ZIP file name based on the stream session
    #   metadata. Alternatively, you can provide a custom file name with a
    #   `.zip` file extension.
    #
    #   Example 1: If you provide an S3 URI called
    #   `s3://MyBucket/MyGame_Session1.zip`, then Amazon GameLift Streams
    #   will save the files at that location.
    #
    #   Example 2: If you provide an S3 URI called
    #   `s3://MyBucket/MyGameSessions_ExportedFiles/`, then Amazon GameLift
    #   Streams will save the files at
    #   `s3://MyBucket/MyGameSessions_ExportedFiles/YYYYMMDD-HHMMSS-appId-sg-Id-sessionId.zip`
    #   or another similar name.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The result of the ExportStreamSessionFiles operation.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason the export is in `FAILED` status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ExportFilesMetadata AWS API Documentation
    #
    class ExportFilesMetadata < Struct.new(
      :output_uri,
      :status,
      :status_reason)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] output_uri
    #   The S3 bucket URI where Amazon GameLift Streams uploads the set of
    #   compressed exported files for this stream session. Amazon GameLift
    #   Streams generates a ZIP file name based on the stream session
    #   metadata. Alternatively, you can provide a custom file name with a
    #   `.zip` file extension.
    #
    #   Example 1: If you provide an S3 URI called
    #   `s3://MyBucket/MyGame_Session1.zip`, then Amazon GameLift Streams
    #   will save the files at that location.
    #
    #   Example 2: If you provide an S3 URI called
    #   `s3://MyBucket/MyGameSessions_ExportedFiles/`, then Amazon GameLift
    #   Streams will save the files at
    #   `s3://MyBucket/MyGameSessions_ExportedFiles/YYYYMMDD-HHMMSS-appId-sg-Id-sessionId.zip`
    #   or another similar name.
    #   @return [String]
    #
    # @!attribute [rw] stream_session_identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream session resource. Format example: `1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ExportStreamSessionFilesInput AWS API Documentation
    #
    class ExportStreamSessionFilesInput < Struct.new(
      :identifier,
      :output_uri,
      :stream_session_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ExportStreamSessionFilesOutput AWS API Documentation
    #
    class ExportStreamSessionFilesOutput < Aws::EmptyStructure; end

    # @!attribute [rw] identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetApplicationInput AWS API Documentation
    #
    class GetApplicationInput < Struct.new(
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_log_output_uri
    #   An Amazon S3 URI to a bucket where you would like Amazon GameLift
    #   Streams to save application logs. Use the following format for the
    #   URI: `s3://[bucket name]/[prefix]`. Required if you specify one or
    #   more `LogPaths`.
    #   @return [String]
    #
    # @!attribute [rw] application_log_paths
    #   Locations of log files that your content generates during a stream
    #   session. Amazon GameLift Streams uploads log files to the Amazon S3
    #   bucket that you specify in `ApplicationLogOutputUri` at the end of a
    #   stream session. To retrieve stored log files, call GetStreamSession
    #   and get the `LogFileLocationUri`.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_source_uri
    #   The original Amazon S3 location of uploaded stream content for the
    #   application.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that's assigned to an application
    #   resource and uniquely identifies it across all Amazon Web Services
    #   Regions. Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    #   account]:application/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_stream_groups
    #   A set of stream groups that this application is associated with. You
    #   can use any of these stream groups to stream your application.
    #
    #   This value is a set of [Amazon Resource Names (ARNs)][1] that
    #   uniquely identify stream group resources. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application. You can edit this value.
    #   @return [String]
    #
    # @!attribute [rw] executable_path
    #   The path and file name of the executable file that launches the
    #   content for streaming.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] replication_statuses
    #   A set of replication statuses for each location.
    #   @return [Array<Types::ReplicationStatus>]
    #
    # @!attribute [rw] runtime_environment
    #   A set of configuration settings to run the application on a stream
    #   group. This configures the operating system, and can include
    #   compatibility layers and other drivers.
    #
    #   A runtime environment can be one of the following:
    #
    #   * For Linux applications
    #
    #     * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #     ^
    #   * For Windows applications
    #
    #     * Microsoft Windows Server 2022 Base (`Type=WINDOWS,
    #       Version=2022`)
    #
    #     * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #     * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #   @return [Types::RuntimeEnvironment]
    #
    # @!attribute [rw] status
    #   The current status of the application resource. Possible statuses
    #   include the following:
    #
    #   * `INITIALIZED`: Amazon GameLift Streams has received the request
    #     and is initiating the work flow to create an application.
    #
    #   * `PROCESSING`: The create application work flow is in process.
    #     Amazon GameLift Streams is copying the content and caching for
    #     future deployment in a stream group.
    #
    #   * `READY`: The application is ready to deploy in a stream group.
    #
    #   * `ERROR`: An error occurred when setting up the application. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the application.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the status reason when the application is in
    #   `ERROR` status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetApplicationOutput AWS API Documentation
    #
    class GetApplicationOutput < Struct.new(
      :application_log_output_uri,
      :application_log_paths,
      :application_source_uri,
      :arn,
      :associated_stream_groups,
      :created_at,
      :description,
      :executable_path,
      :id,
      :last_updated_at,
      :replication_statuses,
      :runtime_environment,
      :status,
      :status_reason)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The unique ID value of the stream group resource to retrieve. Format
    #   example: `1AB2C3De4`.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetStreamGroupInput AWS API Documentation
    #
    class GetStreamGroupInput < Struct.new(
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that is assigned to the stream group
    #   resource and that uniquely identifies the group across all Amazon
    #   Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    #   Region]:[AWS account]:streamgroup/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_applications
    #   A set of applications that this stream group is associated to. You
    #   can stream any of these applications by using this stream group.
    #
    #   This value is a set of [Amazon Resource Names (ARNs)][1] that
    #   uniquely identify application resources. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] default_application
    #   The Amazon GameLift Streams application that is associated with this
    #   stream group.
    #   @return [Types::DefaultApplication]
    #
    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   A unique ID value that is assigned to the resource when it's
    #   created. Format example: `1AB2C3De4`.
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location_states
    #   This value is the set of locations, including their name, current
    #   status, and capacities.
    #
    #   A location can be in one of the following states:
    #
    #   * **ACTIVATING**: Amazon GameLift Streams is preparing the location.
    #     You cannot stream from, scale the capacity of, or remove this
    #     location yet.
    #
    #   * **ACTIVE**: The location is provisioned with initial capacity. You
    #     can now stream from, scale the capacity of, or remove this
    #     location.
    #
    #   * **ERROR**: Amazon GameLift Streams failed to set up this location.
    #     The StatusReason field describes the error. You can remove this
    #     location and try to add it again.
    #
    #   * **REMOVING**: Amazon GameLift Streams is working to remove this
    #     location. It releases all provisioned capacity for this location
    #     in this stream group.
    #   @return [Array<Types::LocationState>]
    #
    # @!attribute [rw] status
    #   The current status of the stream group resource. Possible statuses
    #   include the following:
    #
    #   * `ACTIVATING`: The stream group is deploying and isn't ready to
    #     host streams.
    #
    #   * `ACTIVE`: The stream group is ready to host streams.
    #
    #   * `ACTIVE_WITH_ERRORS`: One or more locations in the stream group
    #     are in an error state. Verify the details of individual locations
    #     and remove any locations which are in error.
    #
    #   * `ERROR`: An error occurred when the stream group deployed. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the stream group.
    #
    #   * `UPDATING_LOCATIONS`: One or more locations in the stream group
    #     are in the process of updating (either activating or deleting).
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason that the stream group is in
    #   `ERROR` status. The possible reasons can be one of the following:
    #
    #   * `internalError`: The request can't process right now bcause of an
    #     issue with the server. Try again later. Reach out to the Amazon
    #     GameLift Streams team for more help.
    #
    #   * `noAvailableInstances`: Amazon GameLift Streams does not currently
    #     have enough available On-Demand capacity to fulfill your request.
    #     Wait a few minutes and retry the request as capacity can shift
    #     frequently. You can also try to make the request using a different
    #     stream class or in another region.
    #   @return [String]
    #
    # @!attribute [rw] stream_class
    #   The target stream quality for the stream group.
    #
    #   A stream class can be one of the following:
    #
    #   * <b> <code>gen5n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.x builds, 32-bit
    #     applications, and anti-cheat technology. Uses NVIDIA A10G Tensor
    #     GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen5n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen5n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Uses
    #     dedicated NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.2 and 5.3 builds,
    #     32-bit applications, and anti-cheat technology. Uses NVIDIA T4
    #     Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen4n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with high 3D scene complexity. Uses dedicated NVIDIA
    #     T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetStreamGroupOutput AWS API Documentation
    #
    class GetStreamGroupOutput < Struct.new(
      :arn,
      :associated_applications,
      :created_at,
      :default_application,
      :description,
      :id,
      :last_updated_at,
      :location_states,
      :status,
      :status_reason,
      :stream_class)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   The stream group that runs this stream session.
    #
    #   This value is an [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] stream_session_identifier
    #   An [Amazon Resource Name (ARN)][1] that uniquely identifies the
    #   stream session resource. Format example: `1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetStreamSessionInput AWS API Documentation
    #
    class GetStreamSessionInput < Struct.new(
      :identifier,
      :stream_session_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] additional_environment_variables
    #   A set of options that you can use to control the stream session
    #   runtime environment, expressed as a set of key-value pairs. You can
    #   use this to configure the application or stream session details. You
    #   can also provide custom environment variables that Amazon GameLift
    #   Streams passes to your game client.
    #
    #   <note markdown="1"> If you want to debug your application with environment variables, we
    #   recommend that you do so in a local environment outside of Amazon
    #   GameLift Streams. For more information, refer to the Compatibility
    #   Guidance in the troubleshooting section of the Developer Guide.
    #
    #    </note>
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] additional_launch_args
    #   A list of CLI arguments that are sent to the streaming server when a
    #   stream session launches. You can use this to configure the
    #   application or stream session details. You can also provide custom
    #   arguments that Amazon GameLift Streams passes to your game client.
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_arn
    #   The application streaming in this session.
    #
    #   This value is an [Amazon Resource Name (ARN)][1] that uniquely
    #   identifies the application resource. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) assigned to the stream session
    #   resource. When combined with the stream group ARN, this value
    #   uniquely identifies it across all Amazon Web Services Regions.
    #   Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    #   account]:streamsession/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] connection_timeout_seconds
    #   The maximum length of time (in seconds) that Amazon GameLift Streams
    #   keeps the stream session open. At this point, Amazon GameLift
    #   Streams ends the stream session regardless of any existing client
    #   connections.
    #   @return [Integer]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the stream session. You can update this
    #   value at any time.
    #   @return [String]
    #
    # @!attribute [rw] export_files_metadata
    #   Provides details about the stream session's exported files.
    #   @return [Types::ExportFilesMetadata]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location
    #   The location where Amazon GameLift Streams is hosting the stream
    #   session.
    #
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] log_file_location_uri
    #   Access location for log files that your content generates during a
    #   stream session. These log files are uploaded to cloud storage
    #   location at the end of a stream session. The Amazon GameLift Streams
    #   application resource defines which log files to upload.
    #   @return [String]
    #
    # @!attribute [rw] protocol
    #   The data transfer protocol in use with the stream session.
    #   @return [String]
    #
    # @!attribute [rw] session_length_seconds
    #   The length of time that Amazon GameLift Streams keeps the game
    #   session open.
    #   @return [Integer]
    #
    # @!attribute [rw] signal_request
    #   The WebRTC ICE offer string that a client generates to initiate a
    #   connection to the stream session.
    #   @return [String]
    #
    # @!attribute [rw] signal_response
    #   The WebRTC answer string that the stream server generates in
    #   response to the `SignalRequest`.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the stream session. A stream session can host
    #   clients when in `ACTIVE` status.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason the stream session is in `ERROR`
    #   status.
    #   @return [String]
    #
    # @!attribute [rw] stream_group_id
    #   The unique identifier for the Amazon GameLift Streams stream group
    #   that is hosting the stream session.
    #   @return [String]
    #
    # @!attribute [rw] user_id
    #   An opaque, unique identifier for an end-user, defined by the
    #   developer.
    #   @return [String]
    #
    # @!attribute [rw] web_sdk_protocol_url
    #   The URL of an S3 bucket that stores Amazon GameLift Streams WebSDK
    #   files. The URL is used to establish connection with the client.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/GetStreamSessionOutput AWS API Documentation
    #
    class GetStreamSessionOutput < Struct.new(
      :additional_environment_variables,
      :additional_launch_args,
      :application_arn,
      :arn,
      :connection_timeout_seconds,
      :created_at,
      :description,
      :export_files_metadata,
      :last_updated_at,
      :location,
      :log_file_location_uri,
      :protocol,
      :session_length_seconds,
      :signal_request,
      :signal_response,
      :status,
      :status_reason,
      :stream_group_id,
      :user_id,
      :web_sdk_protocol_url)
      SENSITIVE = [:signal_request, :signal_response]
      include Aws::Structure
    end

    # The service encountered an internal error and is unable to complete
    # the request.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/InternalServerException AWS API Documentation
    #
    class InternalServerException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   The number of results to return. Use this parameter with `NextToken`
    #   to return results in sequential pages. Default value is `25`.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The token that marks the start of the next set of results. Use this
    #   token when you retrieve results as sequential pages. To get the
    #   first page of results, omit a token value. To get the remaining
    #   pages, provide the token returned with the previous result set.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListApplicationsInput AWS API Documentation
    #
    class ListApplicationsInput < Struct.new(
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] items
    #   A collection of Amazon GameLift Streams applications that are
    #   associated with the Amazon Web Services account in use. Each item
    #   includes application metadata and status.
    #   @return [Array<Types::ApplicationSummary>]
    #
    # @!attribute [rw] next_token
    #   A token that marks the start of the next sequential page of results.
    #   If an operation doesn't return a token, you've reached the end of
    #   the list.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListApplicationsOutput AWS API Documentation
    #
    class ListApplicationsOutput < Struct.new(
      :items,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   The number of results to return. Use this parameter with `NextToken`
    #   to return results in sequential pages. Default value is `25`.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   A token that marks the start of the next set of results. Use this
    #   token when you retrieve results as sequential pages. To get the
    #   first page of results, omit a token value. To get the remaining
    #   pages, provide the token returned with the previous result set.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamGroupsInput AWS API Documentation
    #
    class ListStreamGroupsInput < Struct.new(
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] items
    #   A collection of Amazon GameLift Streams stream groups that are
    #   associated with the Amazon Web Services account in use. Each item
    #   includes stream group metadata and status, but doesn't include
    #   capacity information.
    #   @return [Array<Types::StreamGroupSummary>]
    #
    # @!attribute [rw] next_token
    #   A token that marks the start of the next sequential page of results.
    #   If an operation doesn't return a token, you've reached the end of
    #   the list.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamGroupsOutput AWS API Documentation
    #
    class ListStreamGroupsOutput < Struct.new(
      :items,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] export_files_status
    #   Filter by the exported files status. You can specify one status in
    #   each request to retrieve only sessions that currently have that
    #   exported files status.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The number of results to return. Use this parameter with `NextToken`
    #   to return results in sequential pages. Default value is `25`.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The token that marks the start of the next set of results. Use this
    #   token when you retrieve results as sequential pages. To get the
    #   first page of results, omit a token value. To get the remaining
    #   pages, provide the token returned with the previous result set.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   Filter by the stream session status. You can specify one status in
    #   each request to retrieve only sessions that are currently in that
    #   status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamSessionsByAccountInput AWS API Documentation
    #
    class ListStreamSessionsByAccountInput < Struct.new(
      :export_files_status,
      :max_results,
      :next_token,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] items
    #   A collection of Amazon GameLift Streams stream sessions that are
    #   associated with a stream group and returned in response to a list
    #   request. Each item includes stream session metadata and status.
    #   @return [Array<Types::StreamSessionSummary>]
    #
    # @!attribute [rw] next_token
    #   A token that marks the start of the next sequential page of results.
    #   If an operation doesn't return a token, you've reached the end of
    #   the list.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamSessionsByAccountOutput AWS API Documentation
    #
    class ListStreamSessionsByAccountOutput < Struct.new(
      :items,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] export_files_status
    #   Filter by the exported files status. You can specify one status in
    #   each request to retrieve only sessions that currently have that
    #   exported files status.
    #
    #   Exported files can be in one of the following states:
    #
    #   * **SUCCEEDED**: The exported files are successfully stored in S3
    #     bucket.
    #
    #   * **FAILED**: The session ended but Amazon GameLift Streams
    #     couldn't collect and upload the to S3.
    #
    #   * **PENDING**: Either the stream session is still in progress, or
    #     uploading the exported files to the S3 bucket is in progress.
    #   @return [String]
    #
    # @!attribute [rw] identifier
    #   The unique identifier of a Amazon GameLift Streams stream group to
    #   retrieve the stream session for. You can use either the stream group
    #   ID or the Amazon Resource Name (ARN).
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The number of results to return. Use this parameter with `NextToken`
    #   to return results in sequential pages. Default value is `25`.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The token that marks the start of the next set of results. Use this
    #   token when you retrieve results as sequential pages. To get the
    #   first page of results, omit a token value. To get the remaining
    #   pages, provide the token returned with the previous result set.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   Filter by the stream session status. You can specify one status in
    #   each request to retrieve only sessions that are currently in that
    #   status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamSessionsInput AWS API Documentation
    #
    class ListStreamSessionsInput < Struct.new(
      :export_files_status,
      :identifier,
      :max_results,
      :next_token,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] items
    #   A collection of Amazon GameLift Streams stream sessions that are
    #   associated with a stream group and returned in response to a list
    #   request. Each item includes stream session metadata and status.
    #   @return [Array<Types::StreamSessionSummary>]
    #
    # @!attribute [rw] next_token
    #   A token that marks the start of the next sequential page of results.
    #   If an operation doesn't return a token, you've reached the end of
    #   the list.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListStreamSessionsOutput AWS API Documentation
    #
    class ListStreamSessionsOutput < Struct.new(
      :items,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The ([Amazon Resource Name (ARN)][1] that you want to retrieve tags
    #   for. To get a Amazon GameLift Streams resource ARN, call a List or
    #   Get operation for the resource.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListTagsForResourceRequest AWS API Documentation
    #
    class ListTagsForResourceRequest < Struct.new(
      :resource_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] tags
    #   A collection of tags that have been assigned to the specified
    #   resource.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ListTagsForResourceResponse AWS API Documentation
    #
    class ListTagsForResourceResponse < Struct.new(
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # Configuration settings that define a stream group's stream capacity
    # for a location. When configuring a location for the first time, you
    # must specify a numeric value for at least one of the two capacity
    # types. To update the capacity for an existing stream group, call
    # UpdateStreamGroup. To add a new location and specify its capacity,
    # call AddStreamGroupLocations.
    #
    # @!attribute [rw] always_on_capacity
    #   The streaming capacity that is allocated and ready to handle stream
    #   requests without delay. You pay for this capacity whether it's in
    #   use or not. Best for quickest time from streaming request to
    #   streaming session.
    #   @return [Integer]
    #
    # @!attribute [rw] location_name
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] on_demand_capacity
    #   The streaming capacity that Amazon GameLift Streams can allocate in
    #   response to stream requests, and then de-allocate when the session
    #   has terminated. This offers a cost control measure at the expense of
    #   a greater startup time (typically under 5 minutes).
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/LocationConfiguration AWS API Documentation
    #
    class LocationConfiguration < Struct.new(
      :always_on_capacity,
      :location_name,
      :on_demand_capacity)
      SENSITIVE = []
      include Aws::Structure
    end

    # Represents a location and its corresponding stream capacity and
    # status.
    #
    # @!attribute [rw] allocated_capacity
    #   This value is the number of compute resources that a stream group
    #   has provisioned and is ready to stream. It includes resources that
    #   are currently streaming and resources that are idle and ready to
    #   respond to stream requests.
    #   @return [Integer]
    #
    # @!attribute [rw] always_on_capacity
    #   The streaming capacity that is allocated and ready to handle stream
    #   requests without delay. You pay for this capacity whether it's in
    #   use or not. Best for quickest time from streaming request to
    #   streaming session.
    #   @return [Integer]
    #
    # @!attribute [rw] idle_capacity
    #   This value is the amount of allocated capacity that is not currently
    #   streaming. It represents the stream group's availability to respond
    #   to new stream requests, but not including on-demand capacity.
    #   @return [Integer]
    #
    # @!attribute [rw] location_name
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] on_demand_capacity
    #   The streaming capacity that Amazon GameLift Streams can allocate in
    #   response to stream requests, and then de-allocate when the session
    #   has terminated. This offers a cost control measure at the expense of
    #   a greater startup time (typically under 5 minutes).
    #   @return [Integer]
    #
    # @!attribute [rw] requested_capacity
    #   This value is the total number of compute resources that you request
    #   for a stream group. This includes resources that Amazon GameLift
    #   Streams has either already provisioned or is working to provision.
    #   You request capacity for each location in a stream group.
    #   @return [Integer]
    #
    # @!attribute [rw] status
    #   This value is set of locations, including their name, current
    #   status, and capacities.
    #
    #   A location can be in one of the following states:
    #
    #   * **ACTIVATING**: Amazon GameLift Streams is preparing the location.
    #     You cannot stream from, scale the capacity of, or remove this
    #     location yet.
    #
    #   * **ACTIVE**: The location is provisioned with initial capacity. You
    #     can now stream from, scale the capacity of, or remove this
    #     location.
    #
    #   * **ERROR**: Amazon GameLift Streams failed to set up this location.
    #     The StatusReason field describes the error. You can remove this
    #     location and try to add it again.
    #
    #   * **REMOVING**: Amazon GameLift Streams is working to remove this
    #     location. It releases all provisioned capacity for this location
    #     in this stream group.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/LocationState AWS API Documentation
    #
    class LocationState < Struct.new(
      :allocated_capacity,
      :always_on_capacity,
      :idle_capacity,
      :location_name,
      :on_demand_capacity,
      :requested_capacity,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] identifier
    #   A stream group to remove the specified locations from.
    #
    #   This value is a Amazon Resource Name (ARN) that uniquely identifies
    #   the stream group resource. Format example: `1AB2C3De4`.      </p>
    #   @return [String]
    #
    # @!attribute [rw] locations
    #   A set of locations to remove this stream group.
    #
    #   A set of location names. For example, `us-east-1`. For a complete
    #   list of locations that Amazon GameLift Streams supports, see the
    #   Regions and quotas section in the Amazon GameLift Streams Developer
    #   Guide .      </p>
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/RemoveStreamGroupLocationsInput AWS API Documentation
    #
    class RemoveStreamGroupLocationsInput < Struct.new(
      :identifier,
      :locations)
      SENSITIVE = []
      include Aws::Structure
    end

    # Represents the status of the replication of an application to a
    # location. An application cannot be streamed from a location until it
    # has finished replicating there.
    #
    # @!attribute [rw] location
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the replication process.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ReplicationStatus AWS API Documentation
    #
    class ReplicationStatus < Struct.new(
      :location,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # The resource specified in the request was not found. Correct the
    # request before you try again.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ResourceNotFoundException AWS API Documentation
    #
    class ResourceNotFoundException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Configuration settings that identify the operating system for an
    # application resource. This can also include a compatibility layer and
    # other drivers.
    #
    # A runtime environment can be one of the following:
    #
    # * For Linux applications
    #
    #   * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #   ^
    # * For Windows applications
    #
    #   * Microsoft Windows Server 2022 Base (`Type=WINDOWS, Version=2022`)
    #
    #   * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #   * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #
    # @!attribute [rw] type
    #   The operating system and other drivers. For Proton, this also
    #   includes the Proton compatibility layer.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   Versioned container environment for the application operating
    #   system.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/RuntimeEnvironment AWS API Documentation
    #
    class RuntimeEnvironment < Struct.new(
      :type,
      :version)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request would cause the resource to exceed an allowed service
    # quota. Resolve the issue before you try again.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ServiceQuotaExceededException AWS API Documentation
    #
    class ServiceQuotaExceededException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] additional_environment_variables
    #   A set of options that you can use to control the stream session
    #   runtime environment, expressed as a set of key-value pairs. You can
    #   use this to configure the application or stream session details. You
    #   can also provide custom environment variables that Amazon GameLift
    #   Streams passes to your game client.
    #
    #   <note markdown="1"> If you want to debug your application with environment variables, we
    #   recommend that you do so in a local environment outside of Amazon
    #   GameLift Streams. For more information, refer to the Compatibility
    #   Guidance in the troubleshooting section of the Developer Guide.
    #
    #    </note>
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] additional_launch_args
    #   A list of CLI arguments that are sent to the streaming server when a
    #   stream session launches. You can use this to configure the
    #   application or stream session details. You can also provide custom
    #   arguments that Amazon GameLift Streams passes to your game client.
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] client_token
    #   A unique identifier that represents a client request. The request is
    #   idempotent, which ensures that an API request completes only once.
    #   When users send a request, Amazon GameLift Streams automatically
    #   populates this field.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] connection_timeout_seconds
    #   Length of time (in seconds) that Amazon GameLift Streams should wait
    #   for a client to connect to the stream session. This time span starts
    #   when the stream session reaches `ACTIVE` status. If no client
    #   connects before the timeout, Amazon GameLift Streams stops the
    #   stream session with status of `TERMINATED`. Default value is 120.
    #   @return [Integer]
    #
    # @!attribute [rw] description
    #   A human-readable label for the stream session. You can update this
    #   value later.
    #   @return [String]
    #
    # @!attribute [rw] identifier
    #   The stream group to run this stream session with.
    #
    #   This value is an [Amazon Resource Name (ARN)][1] or ID that uniquely
    #   identifies the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] locations
    #   A list of locations, in order of priority, where you want Amazon
    #   GameLift Streams to start a stream from. Amazon GameLift Streams
    #   selects the location with the next available capacity to start a
    #   single stream session in. If this value is empty, Amazon GameLift
    #   Streams attempts to start a stream session in the primary location.
    #
    #   This value is A set of location names. For example, `us-east-1`. For
    #   a complete list of locations that Amazon GameLift Streams supports,
    #   see the Regions and quotas section in the Amazon GameLift Streams
    #   Developer Guide .      </p>
    #   @return [Array<String>]
    #
    # @!attribute [rw] protocol
    #   The data transport protocol to use for the stream session.
    #   @return [String]
    #
    # @!attribute [rw] session_length_seconds
    #   The maximum length of time (in seconds) that Amazon GameLift Streams
    #   keeps the stream session open. At this point, Amazon GameLift
    #   Streams ends the stream session regardless of any existing client
    #   connections. Default value is 43200.
    #   @return [Integer]
    #
    # @!attribute [rw] signal_request
    #   A WebRTC ICE offer string to use when initializing a WebRTC
    #   connection. The offer is a very long JSON string. Provide the string
    #   as a text value in quotes.
    #   @return [String]
    #
    # @!attribute [rw] user_id
    #   An opaque, unique identifier for an end-user, defined by the
    #   developer.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/StartStreamSessionInput AWS API Documentation
    #
    class StartStreamSessionInput < Struct.new(
      :additional_environment_variables,
      :additional_launch_args,
      :application_identifier,
      :client_token,
      :connection_timeout_seconds,
      :description,
      :identifier,
      :locations,
      :protocol,
      :session_length_seconds,
      :signal_request,
      :user_id)
      SENSITIVE = [:signal_request]
      include Aws::Structure
    end

    # @!attribute [rw] additional_environment_variables
    #   A set of options that you can use to control the stream session
    #   runtime environment, expressed as a set of key-value pairs. You can
    #   use this to configure the application or stream session details. You
    #   can also provide custom environment variables that Amazon GameLift
    #   Streams passes to your game client.
    #
    #   <note markdown="1"> If you want to debug your application with environment variables, we
    #   recommend that you do so in a local environment outside of Amazon
    #   GameLift Streams. For more information, refer to the Compatibility
    #   Guidance in the troubleshooting section of the Developer Guide.
    #
    #    </note>
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] additional_launch_args
    #   A list of CLI arguments that are sent to the streaming server when a
    #   stream session launches. You can use this to configure the
    #   application or stream session details. You can also provide custom
    #   arguments that Amazon GameLift Streams passes to your game client.
    #
    #   `AdditionalEnvironmentVariables` and `AdditionalLaunchArgs` have
    #   similar purposes. `AdditionalEnvironmentVariables` passes data using
    #   environment variables; while `AdditionalLaunchArgs` passes data
    #   using command-line arguments.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_arn
    #   An [Amazon Resource Name (ARN)][1] that uniquely identifies the
    #   application resource. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The Amazon Resource Name (ARN) assigned to the stream session
    #   resource. When combined with the stream group ARN, this value
    #   uniquely identifies it across all Amazon Web Services Regions.
    #   Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    #   account]:streamsession/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] connection_timeout_seconds
    #   The maximum length of time (in seconds) that Amazon GameLift Streams
    #   keeps the stream session open. At this point, Amazon GameLift
    #   Streams ends the stream session regardless of any existing client
    #   connections.
    #   @return [Integer]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the stream session. You can update this
    #   value at any time.
    #   @return [String]
    #
    # @!attribute [rw] export_files_metadata
    #   Provides details about the stream session's exported files.
    #   @return [Types::ExportFilesMetadata]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location
    #   The location where Amazon GameLift Streams is streaming your
    #   application from.
    #
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] log_file_location_uri
    #   Access location for log files that your content generates during a
    #   stream session. These log files are uploaded to cloud storage
    #   location at the end of a stream session. The Amazon GameLift Streams
    #   application resource defines which log files to upload.
    #   @return [String]
    #
    # @!attribute [rw] protocol
    #   The data transfer protocol in use with the stream session.
    #   @return [String]
    #
    # @!attribute [rw] session_length_seconds
    #   The length of time that Amazon GameLift Streams keeps the game
    #   session open.
    #   @return [Integer]
    #
    # @!attribute [rw] signal_request
    #   The WebRTC ICE offer string that a client generates to initiate a
    #   connection to the stream session.
    #   @return [String]
    #
    # @!attribute [rw] signal_response
    #   The WebRTC answer string that the stream server generates in
    #   response to the `SignalRequest`.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the stream session. A stream session can host
    #   clients when in `ACTIVE` status.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason the stream session is in `ERROR`
    #   status.
    #   @return [String]
    #
    # @!attribute [rw] stream_group_id
    #   The unique identifier for the Amazon GameLift Streams stream group
    #   that is hosting the stream session.
    #   @return [String]
    #
    # @!attribute [rw] user_id
    #   An opaque, unique identifier for an end-user, defined by the
    #   developer.
    #   @return [String]
    #
    # @!attribute [rw] web_sdk_protocol_url
    #   The URL of an S3 bucket that stores Amazon GameLift Streams WebSDK
    #   files. The URL is used to establish connection with the client.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/StartStreamSessionOutput AWS API Documentation
    #
    class StartStreamSessionOutput < Struct.new(
      :additional_environment_variables,
      :additional_launch_args,
      :application_arn,
      :arn,
      :connection_timeout_seconds,
      :created_at,
      :description,
      :export_files_metadata,
      :last_updated_at,
      :location,
      :log_file_location_uri,
      :protocol,
      :session_length_seconds,
      :signal_request,
      :signal_response,
      :status,
      :status_reason,
      :stream_group_id,
      :user_id,
      :web_sdk_protocol_url)
      SENSITIVE = [:signal_request, :signal_response]
      include Aws::Structure
    end

    # Describes a Amazon GameLift Streams stream group resource for hosting
    # content streams. To retrieve additional stream group details, call
    # GetStreamGroup.
    #
    # @!attribute [rw] arn
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] default_application
    #   Object that identifies the Amazon GameLift Streams application to
    #   stream with this stream group.
    #   @return [Types::DefaultApplication]
    #
    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] status
    #   The current status of the stream group resource. Possible statuses
    #   include the following:
    #
    #   * `ACTIVATING`: The stream group is deploying and isn't ready to
    #     host streams.
    #
    #   * `ACTIVE`: The stream group is ready to host streams.
    #
    #   * `ACTIVE_WITH_ERRORS`: One or more locations in the stream group
    #     are in an error state. Verify the details of individual locations
    #     and remove any locations which are in error.
    #
    #   * `ERROR`: An error occurred when the stream group deployed. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the stream group.
    #
    #   * `UPDATING_LOCATIONS`: One or more locations in the stream group
    #     are in the process of updating (either activating or deleting).
    #   @return [String]
    #
    # @!attribute [rw] stream_class
    #   The target stream quality for the stream group.
    #
    #   A stream class can be one of the following:
    #
    #   * <b> <code>gen5n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.x builds, 32-bit
    #     applications, and anti-cheat technology. Uses NVIDIA A10G Tensor
    #     GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen5n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen5n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Uses
    #     dedicated NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.2 and 5.3 builds,
    #     32-bit applications, and anti-cheat technology. Uses NVIDIA T4
    #     Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen4n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with high 3D scene complexity. Uses dedicated NVIDIA
    #     T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/StreamGroupSummary AWS API Documentation
    #
    class StreamGroupSummary < Struct.new(
      :arn,
      :created_at,
      :default_application,
      :description,
      :id,
      :last_updated_at,
      :status,
      :stream_class)
      SENSITIVE = []
      include Aws::Structure
    end

    # Describes a Amazon GameLift Streams stream session. To retrieve
    # additional details for the stream session, call GetStreamSession.
    #
    # @!attribute [rw] application_arn
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   An [Amazon Resource Name (ARN)][1] that uniquely identifies the
    #   stream session resource. Format example: `1AB2C3De4`. .
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] export_files_metadata
    #   Provides details about the stream session's exported files.
    #   @return [Types::ExportFilesMetadata]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location
    #   The location where Amazon GameLift Streams is hosting the stream
    #   session.
    #
    #   A location's name. For example, `us-east-1`. For a complete list of
    #   locations that Amazon GameLift Streams supports, see the Regions and
    #   quotas section in the Amazon GameLift Streams Developer Guide .
    #   @return [String]
    #
    # @!attribute [rw] protocol
    #   The data transfer protocol in use with the stream session.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the stream session resource. Possible statuses
    #   include the following:
    #
    #   * `ACTIVATING`: The stream session is starting and preparing to
    #     stream.
    #
    #   * `ACTIVE`: The stream session is ready to accept client
    #     connections.
    #
    #   * `CONNECTED`: The stream session has a connected client.
    #
    #   * `PENDING_CLIENT_RECONNECTION`: A client has recently disconnected,
    #     and the stream session is waiting for the client to reconnect.
    #     After a short time, if the client doesn't reconnect, the stream
    #     session status transitions to `TERMINATED`.
    #
    #   * `TERMINATING`: The stream session is ending.
    #
    #   * `TERMINATED`: The stream session has ended.
    #
    #   * `ERROR`: The stream session failed to activate.
    #   @return [String]
    #
    # @!attribute [rw] user_id
    #   An opaque, unique identifier for an end-user, defined by the
    #   developer.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/StreamSessionSummary AWS API Documentation
    #
    class StreamSessionSummary < Struct.new(
      :application_arn,
      :arn,
      :created_at,
      :export_files_metadata,
      :last_updated_at,
      :location,
      :protocol,
      :status,
      :user_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The [Amazon Resource Name (ARN)][1] of the Amazon GameLift Streams
    #   resource that you want to apply tags to.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   A list of tags, in the form of key-value pairs, to assign to the
    #   specified Amazon GameLift Streams resource.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/TagResourceRequest AWS API Documentation
    #
    class TagResourceRequest < Struct.new(
      :resource_arn,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/TagResourceResponse AWS API Documentation
    #
    class TagResourceResponse < Aws::EmptyStructure; end

    # @!attribute [rw] identifier
    #   [Amazon Resource Name (ARN)][1] or ID that uniquely identifies the
    #   stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #   The stream group that runs this stream session.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] stream_session_identifier
    #   [Amazon Resource Name (ARN)][1] that uniquely identifies the stream
    #   session resource. Format example: `1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/TerminateStreamSessionInput AWS API Documentation
    #
    class TerminateStreamSessionInput < Struct.new(
      :identifier,
      :stream_session_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request was denied due to request throttling. Retry the request
    # after the suggested wait time.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ThrottlingException AWS API Documentation
    #
    class ThrottlingException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The [Amazon Resource Name (ARN)][1] of the Amazon GameLift Streams
    #   resource that you want to remove tags from.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html
    #   @return [String]
    #
    # @!attribute [rw] tag_keys
    #   A list of tag keys to remove from the specified Amazon GameLift
    #   Streams resource.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UntagResourceRequest AWS API Documentation
    #
    class UntagResourceRequest < Struct.new(
      :resource_arn,
      :tag_keys)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UntagResourceResponse AWS API Documentation
    #
    class UntagResourceResponse < Aws::EmptyStructure; end

    # @!attribute [rw] application_log_output_uri
    #   An Amazon S3 URI to a bucket where you would like Amazon GameLift
    #   Streams to save application logs. Use the following format for the
    #   URI: `s3://[bucket name]/[prefix]`. Required if you specify one or
    #   more `LogPaths`.
    #
    #   <note markdown="1"> The log bucket must have permissions that give Amazon GameLift
    #   Streams access to write the log files. For more information, see
    #   **Getting Started** in the Amazon GameLift Streams Developer Guide.
    #
    #    </note>
    #   @return [String]
    #
    # @!attribute [rw] application_log_paths
    #   Locations of log files that your content generates during a stream
    #   session. Enter path values that are relative to the
    #   `ApplicationSourceUri` location. You can specify up to 10 log
    #   locations. Amazon GameLift Streams uploads designated log files to
    #   the Amazon S3 bucket that you specify in `ApplicationLogOutputUri`
    #   at the end of a stream session. To retrieve stored log files, call
    #   GetStreamSession and get the `LogFileLocationUri`.
    #   @return [Array<String>]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application.
    #   @return [String]
    #
    # @!attribute [rw] identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UpdateApplicationInput AWS API Documentation
    #
    class UpdateApplicationInput < Struct.new(
      :application_log_output_uri,
      :application_log_paths,
      :description,
      :identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] application_log_output_uri
    #   An Amazon S3 URI to a bucket where you would like Amazon GameLift
    #   Streams to save application logs. Use the following format for the
    #   URI: `s3://[bucket name]/[prefix]`. Required if you specify one or
    #   more `LogPaths`.
    #   @return [String]
    #
    # @!attribute [rw] application_log_paths
    #   Locations of log files that your content generates during a stream
    #   session. Amazon GameLift Streams uploads log files to the Amazon S3
    #   bucket that you specify in `ApplicationLogOutputUri` at the end of a
    #   stream session. To retrieve stored log files, call GetStreamSession
    #   and get the `LogFileLocationUri`.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_source_uri
    #   The original Amazon S3 location of uploaded stream content for the
    #   application.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that's assigned to an application
    #   resource and uniquely identifies it across all Amazon Web Services
    #   Regions. Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    #   account]:application/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_stream_groups
    #   A set of stream groups that this application is associated with. You
    #   can use any of these stream groups to stream your application.
    #
    #   This value is a set of [Amazon Resource Names (ARNs)][1] that
    #   uniquely identify stream group resources. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] description
    #   A human-readable label for the application. You can edit this value.
    #   @return [String]
    #
    # @!attribute [rw] executable_path
    #   The path and file name of the executable file that launches the
    #   content for streaming.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the application resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`
    #   or ID-`9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] replication_statuses
    #   A set of replication statuses for each location.
    #   @return [Array<Types::ReplicationStatus>]
    #
    # @!attribute [rw] runtime_environment
    #   A set of configuration settings to run the application on a stream
    #   group. This configures the operating system, and can include
    #   compatibility layers and other drivers.
    #
    #   A runtime environment can be one of the following:
    #
    #   * For Linux applications
    #
    #     * Ubuntu 22.04 LTS(`Type=UBUNTU, Version=22_04_LTS`)
    #
    #     ^
    #   * For Windows applications
    #
    #     * Microsoft Windows Server 2022 Base (`Type=WINDOWS,
    #       Version=2022`)
    #
    #     * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    #
    #     * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    #   @return [Types::RuntimeEnvironment]
    #
    # @!attribute [rw] status
    #   The current status of the application resource. Possible statuses
    #   include the following:
    #
    #   * `INITIALIZED`: Amazon GameLift Streams has received the request
    #     and is initiating the work flow to create an application.
    #
    #   * `PROCESSING`: The create application work flow is in process.
    #     Amazon GameLift Streams is copying the content and caching for
    #     future deployment in a stream group.
    #
    #   * `READY`: The application is ready to deploy in a stream group.
    #
    #   * `ERROR`: An error occurred when setting up the application. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the application.
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the status reason when the application is in
    #   `ERROR` status.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UpdateApplicationOutput AWS API Documentation
    #
    class UpdateApplicationOutput < Struct.new(
      :application_log_output_uri,
      :application_log_paths,
      :application_source_uri,
      :arn,
      :associated_stream_groups,
      :created_at,
      :description,
      :executable_path,
      :id,
      :last_updated_at,
      :replication_statuses,
      :runtime_environment,
      :status,
      :status_reason)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] identifier
    #   An [Amazon Resource Name (ARN)][1] or ID that uniquely identifies
    #   the stream group resource. Format example:
    #   ARN-`arn:aws:gameliftstreams:us-west-2:123456789012:streamgroup/1AB2C3De4`
    #   or ID-`1AB2C3De4`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [String]
    #
    # @!attribute [rw] location_configurations
    #   A set of one or more locations and the streaming capacity for each
    #   location.
    #   @return [Array<Types::LocationConfiguration>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UpdateStreamGroupInput AWS API Documentation
    #
    class UpdateStreamGroupInput < Struct.new(
      :description,
      :identifier,
      :location_configurations)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] arn
    #   An Amazon Resource Name (ARN) that is assigned to the stream group
    #   resource and that uniquely identifies the group across all Amazon
    #   Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    #   Region]:[AWS account]:streamgroup/[resource ID]`.
    #   @return [String]
    #
    # @!attribute [rw] associated_applications
    #   A set of applications that this stream group is associated with. You
    #   can stream any of these applications with the stream group.
    #
    #   This value is a set of [Amazon Resource Names (ARNs)][1] that
    #   uniquely identify application resources. Format example:
    #   `arn:aws:gameliftstreams:us-west-2:123456789012:application/9ZY8X7Wv6`.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
    #   @return [Array<String>]
    #
    # @!attribute [rw] created_at
    #   A timestamp that indicates when this resource was created.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] default_application
    #   The Amazon GameLift Streams application that is associated with this
    #   stream group.
    #   @return [Types::DefaultApplication]
    #
    # @!attribute [rw] description
    #   A descriptive label for the stream group.
    #   @return [String]
    #
    # @!attribute [rw] id
    #   A unique ID value that is assigned to the resource when it's
    #   created. Format example: `1AB2C3De4`.
    #   @return [String]
    #
    # @!attribute [rw] last_updated_at
    #   A timestamp that indicates when this resource was last updated.
    #   Timestamps are expressed using in ISO8601 format, such as:
    #   `2022-12-27T22:29:40+00:00` (UTC).
    #   @return [Time]
    #
    # @!attribute [rw] location_states
    #   This value is set of locations, including their name, current
    #   status, and capacities.
    #
    #   A location can be in one of the following states:
    #
    #   * **ACTIVATING**: Amazon GameLift Streams is preparing the location.
    #     You cannot stream from, scale the capacity of, or remove this
    #     location yet.
    #
    #   * **ACTIVE**: The location is provisioned with initial capacity. You
    #     can now stream from, scale the capacity of, or remove this
    #     location.
    #
    #   * **ERROR**: Amazon GameLift Streams failed to set up this location.
    #     The StatusReason field describes the error. You can remove this
    #     location and try to add it again.
    #
    #   * **REMOVING**: Amazon GameLift Streams is working to remove this
    #     location. It releases all provisioned capacity for this location
    #     in this stream group.
    #   @return [Array<Types::LocationState>]
    #
    # @!attribute [rw] status
    #   The current status of the stream group resource. Possible statuses
    #   include the following:
    #
    #   * `ACTIVATING`: The stream group is deploying and isn't ready to
    #     host streams.
    #
    #   * `ACTIVE`: The stream group is ready to host streams.
    #
    #   * `ACTIVE_WITH_ERRORS`: One or more locations in the stream group
    #     are in an error state. Verify the details of individual locations
    #     and remove any locations which are in error.
    #
    #   * `ERROR`: An error occurred when the stream group deployed. See
    #     `StatusReason` for more information.
    #
    #   * `DELETING`: Amazon GameLift Streams is in the process of deleting
    #     the stream group.
    #
    #   * `UPDATING_LOCATIONS`: One or more locations in the stream group
    #     are in the process of updating (either activating or deleting).
    #   @return [String]
    #
    # @!attribute [rw] status_reason
    #   A short description of the reason that the stream group is in
    #   `ERROR` status. The possible reasons can be one of the following:
    #
    #   * `internalError`: The request can't process right now bcause of an
    #     issue with the server. Try again later. Reach out to the Amazon
    #     GameLift Streams team for more help.
    #
    #   * `noAvailableInstances`: Amazon GameLift Streams does not currently
    #     have enough available On-Demand capacity to fulfill your request.
    #     Wait a few minutes and retry the request as capacity can shift
    #     frequently. You can also try to make the request using a different
    #     stream class or in another region.
    #   @return [String]
    #
    # @!attribute [rw] stream_class
    #   The target stream quality for the stream group.
    #
    #   A stream class can be one of the following:
    #
    #   * <b> <code>gen5n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.x builds, 32-bit
    #     applications, and anti-cheat technology. Uses NVIDIA A10G Tensor
    #     GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen5n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen5n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Uses
    #     dedicated NVIDIA A10G Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_win2022</code> (NVIDIA, ultra)</b> Supports
    #     applications with extremely high 3D scene complexity. Runs
    #     applications on Microsoft Windows Server 2022 Base and supports
    #     DirectX 12. Compatible with most Unreal Engine 5.2 and 5.3 builds,
    #     32-bit applications, and anti-cheat technology. Uses NVIDIA T4
    #     Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   * <b> <code>gen4n_high</code> (NVIDIA, high)</b> Supports
    #     applications with moderate to high 3D scene complexity. Uses
    #     NVIDIA T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    #
    #     * Tenancy: Supports up to 2 concurrent stream sessions
    #   * <b> <code>gen4n_ultra</code> (NVIDIA, ultra)</b> Supports
    #     applications with high 3D scene complexity. Uses dedicated NVIDIA
    #     T4 Tensor GPU.
    #
    #     * Reference resolution: 1080p
    #
    #     * Reference frame rate: 60 fps
    #
    #     * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    #
    #     * Tenancy: Supports 1 concurrent stream session
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/UpdateStreamGroupOutput AWS API Documentation
    #
    class UpdateStreamGroupOutput < Struct.new(
      :arn,
      :associated_applications,
      :created_at,
      :default_application,
      :description,
      :id,
      :last_updated_at,
      :location_states,
      :status,
      :status_reason,
      :stream_class)
      SENSITIVE = []
      include Aws::Structure
    end

    # One or more parameter values in the request fail to satisfy the
    # specified constraints. Correct the invalid parameter values before
    # retrying the request.
    #
    # @!attribute [rw] message
    #   Description of the error.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/gameliftstreams-2018-05-10/ValidationException AWS API Documentation
    #
    class ValidationException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

  end
end

