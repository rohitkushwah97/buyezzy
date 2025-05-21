# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws::Bedrock
  module Types

    # The request is denied because of missing access permissions.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/AccessDeniedException AWS API Documentation
    #
    class AccessDeniedException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details of an automated evaluation job. The
    # `EvaluationDatasetMetricConfig` object is used to specify the prompt
    # datasets, task type, and metric names.
    #
    # @!attribute [rw] dataset_metric_configs
    #   Configuration details of the prompt datasets and metrics you want to
    #   use for your evaluation job.
    #   @return [Array<Types::EvaluationDatasetMetricConfig>]
    #
    # @!attribute [rw] evaluator_model_config
    #   Contains the evaluator model configuration details.
    #   `EvaluatorModelConfig` is required for evaluation jobs that use a
    #   knowledge base or in model evaluation job that use a model as judge.
    #   This model computes all evaluation related metrics.
    #   @return [Types::EvaluatorModelConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/AutomatedEvaluationConfig AWS API Documentation
    #
    class AutomatedEvaluationConfig < Struct.new(
      :dataset_metric_configs,
      :evaluator_model_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # A JSON array that provides the status of the evaluation jobs being
    # deleted.
    #
    # @!attribute [rw] job_identifier
    #   The ARN of the evaluation job being deleted.
    #   @return [String]
    #
    # @!attribute [rw] code
    #   A HTTP status code of the evaluation job being deleted.
    #   @return [String]
    #
    # @!attribute [rw] message
    #   A status message about the evaluation job deletion.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/BatchDeleteEvaluationJobError AWS API Documentation
    #
    class BatchDeleteEvaluationJobError < Struct.new(
      :job_identifier,
      :code,
      :message)
      SENSITIVE = [:job_identifier]
      include Aws::Structure
    end

    # An evaluation job for deletion, and it’s current status.
    #
    # @!attribute [rw] job_identifier
    #   The Amazon Resource Name (ARN) of the evaluation job for deletion.
    #   @return [String]
    #
    # @!attribute [rw] job_status
    #   The status of the evaluation job for deletion.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/BatchDeleteEvaluationJobItem AWS API Documentation
    #
    class BatchDeleteEvaluationJobItem < Struct.new(
      :job_identifier,
      :job_status)
      SENSITIVE = [:job_identifier]
      include Aws::Structure
    end

    # @!attribute [rw] job_identifiers
    #   A list of one or more evaluation job Amazon Resource Names (ARNs)
    #   you want to delete.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/BatchDeleteEvaluationJobRequest AWS API Documentation
    #
    class BatchDeleteEvaluationJobRequest < Struct.new(
      :job_identifiers)
      SENSITIVE = [:job_identifiers]
      include Aws::Structure
    end

    # @!attribute [rw] errors
    #   A JSON object containing the HTTP status codes and the ARNs of
    #   evaluation jobs that failed to be deleted.
    #   @return [Array<Types::BatchDeleteEvaluationJobError>]
    #
    # @!attribute [rw] evaluation_jobs
    #   The list of evaluation jobs for deletion.
    #   @return [Array<Types::BatchDeleteEvaluationJobItem>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/BatchDeleteEvaluationJobResponse AWS API Documentation
    #
    class BatchDeleteEvaluationJobResponse < Struct.new(
      :errors,
      :evaluation_jobs)
      SENSITIVE = []
      include Aws::Structure
    end

    # The evaluator model used in knowledge base evaluation job or in model
    # evaluation job that use a model as judge. This model computes all
    # evaluation related metrics.
    #
    # @!attribute [rw] model_identifier
    #   The Amazon Resource Name (ARN) of the evaluator model used used in
    #   knowledge base evaluation job or in model evaluation job that use a
    #   model as judge.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/BedrockEvaluatorModel AWS API Documentation
    #
    class BedrockEvaluatorModel < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains the document contained in the wrapper object, along with its
    # attributes/fields.
    #
    # @!attribute [rw] identifier
    #   The file name of the document contained in the wrapper object.
    #   @return [String]
    #
    # @!attribute [rw] content_type
    #   The MIME type of the document contained in the wrapper object.
    #   @return [String]
    #
    # @!attribute [rw] data
    #   The byte value of the file to upload, encoded as a Base-64 string.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ByteContentDoc AWS API Documentation
    #
    class ByteContentDoc < Struct.new(
      :identifier,
      :content_type,
      :data)
      SENSITIVE = [:identifier, :data]
      include Aws::Structure
    end

    # CloudWatch logging configuration.
    #
    # @!attribute [rw] log_group_name
    #   The log group name.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The role Amazon Resource Name (ARN).
    #   @return [String]
    #
    # @!attribute [rw] large_data_delivery_s3_config
    #   S3 configuration for delivering a large amount of data.
    #   @return [Types::S3Config]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CloudWatchConfig AWS API Documentation
    #
    class CloudWatchConfig < Struct.new(
      :log_group_name,
      :role_arn,
      :large_data_delivery_s3_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # Error occurred because of a conflict while performing an operation.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ConflictException AWS API Documentation
    #
    class ConflictException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_name
    #   A name for the evaluation job. Names must unique with your Amazon
    #   Web Services account, and your account's Amazon Web Services
    #   region.
    #   @return [String]
    #
    # @!attribute [rw] job_description
    #   A description of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of an IAM service role that Amazon
    #   Bedrock can assume to perform tasks on your behalf. To learn more
    #   about the required permissions, see [Required permissions for model
    #   evaluations][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-security.html
    #   @return [String]
    #
    # @!attribute [rw] customer_encryption_key_id
    #   Specify your customer managed encryption key Amazon Resource Name
    #   (ARN) that will be used to encrypt your evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] job_tags
    #   Tags to attach to the model evaluation job.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] application_type
    #   Specifies whether the evaluation job is for evaluating a model or
    #   evaluating a knowledge base (retrieval and response generation).
    #   @return [String]
    #
    # @!attribute [rw] evaluation_config
    #   Contains the configuration details of either an automated or
    #   human-based evaluation job.
    #   @return [Types::EvaluationConfig]
    #
    # @!attribute [rw] inference_config
    #   Contains the configuration details of the inference model for the
    #   evaluation job.
    #
    #   For model evaluation jobs, automated jobs support a single model or
    #   [inference profile][1], and jobs that use human workers support two
    #   models or inference profiles.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html
    #   @return [Types::EvaluationInferenceConfig]
    #
    # @!attribute [rw] output_data_config
    #   Contains the configuration details of the Amazon S3 bucket for
    #   storing the results of the evaluation job.
    #   @return [Types::EvaluationOutputDataConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateEvaluationJobRequest AWS API Documentation
    #
    class CreateEvaluationJobRequest < Struct.new(
      :job_name,
      :job_description,
      :client_request_token,
      :role_arn,
      :customer_encryption_key_id,
      :job_tags,
      :application_type,
      :evaluation_config,
      :inference_config,
      :output_data_config)
      SENSITIVE = [:job_description]
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the evaluation job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateEvaluationJobResponse AWS API Documentation
    #
    class CreateEvaluationJobResponse < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name to give the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A description of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] topic_policy_config
    #   The topic policies to configure for the guardrail.
    #   @return [Types::GuardrailTopicPolicyConfig]
    #
    # @!attribute [rw] content_policy_config
    #   The content filter policies to configure for the guardrail.
    #   @return [Types::GuardrailContentPolicyConfig]
    #
    # @!attribute [rw] word_policy_config
    #   The word policy you configure for the guardrail.
    #   @return [Types::GuardrailWordPolicyConfig]
    #
    # @!attribute [rw] sensitive_information_policy_config
    #   The sensitive information policy to configure for the guardrail.
    #   @return [Types::GuardrailSensitiveInformationPolicyConfig]
    #
    # @!attribute [rw] contextual_grounding_policy_config
    #   The contextual grounding policy configuration used to create a
    #   guardrail.
    #   @return [Types::GuardrailContextualGroundingPolicyConfig]
    #
    # @!attribute [rw] blocked_input_messaging
    #   The message to return when the guardrail blocks a prompt.
    #   @return [String]
    #
    # @!attribute [rw] blocked_outputs_messaging
    #   The message to return when the guardrail blocks a model response.
    #   @return [String]
    #
    # @!attribute [rw] kms_key_id
    #   The ARN of the KMS key that you use to encrypt the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   The tags that you want to attach to the guardrail.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than once. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1] in the
    #   *Amazon S3 User Guide*.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateGuardrailRequest AWS API Documentation
    #
    class CreateGuardrailRequest < Struct.new(
      :name,
      :description,
      :topic_policy_config,
      :content_policy_config,
      :word_policy_config,
      :sensitive_information_policy_config,
      :contextual_grounding_policy_config,
      :blocked_input_messaging,
      :blocked_outputs_messaging,
      :kms_key_id,
      :tags,
      :client_request_token)
      SENSITIVE = [:name, :description, :blocked_input_messaging, :blocked_outputs_messaging]
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_id
    #   The unique identifier of the guardrail that was created.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_arn
    #   The ARN of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   The version of the guardrail that was created. This value will
    #   always be `DRAFT`.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The time at which the guardrail was created.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateGuardrailResponse AWS API Documentation
    #
    class CreateGuardrailResponse < Struct.new(
      :guardrail_id,
      :guardrail_arn,
      :version,
      :created_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_identifier
    #   The unique identifier of the guardrail. This can be an ID or the
    #   ARN.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A description of the guardrail version.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than once. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1] in the
    #   *Amazon S3 User Guide*.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateGuardrailVersionRequest AWS API Documentation
    #
    class CreateGuardrailVersionRequest < Struct.new(
      :guardrail_identifier,
      :description,
      :client_request_token)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_id
    #   The unique identifier of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   The number of the version of the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateGuardrailVersionResponse AWS API Documentation
    #
    class CreateGuardrailVersionResponse < Struct.new(
      :guardrail_id,
      :version)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] inference_profile_name
    #   A name for the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A description for the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] model_source
    #   The foundation model or system-defined inference profile that the
    #   inference profile will track metrics and costs for.
    #   @return [Types::InferenceProfileModelSource]
    #
    # @!attribute [rw] tags
    #   An array of objects, each of which contains a tag and its value. For
    #   more information, see [Tagging resources][1] in the [Amazon Bedrock
    #   User Guide][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateInferenceProfileRequest AWS API Documentation
    #
    class CreateInferenceProfileRequest < Struct.new(
      :inference_profile_name,
      :description,
      :client_request_token,
      :model_source,
      :tags)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # @!attribute [rw] inference_profile_arn
    #   The ARN of the inference profile that you created.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the inference profile. `ACTIVE` means that the
    #   inference profile is ready to be used.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateInferenceProfileResponse AWS API Documentation
    #
    class CreateInferenceProfileResponse < Struct.new(
      :inference_profile_arn,
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_source_identifier
    #   The ARN of the model from Amazon Bedrock Marketplace that you want
    #   to deploy to the endpoint.
    #   @return [String]
    #
    # @!attribute [rw] endpoint_config
    #   The configuration for the endpoint, including the number and type of
    #   instances to use.
    #   @return [Types::EndpointConfig]
    #
    # @!attribute [rw] accept_eula
    #   Indicates whether you accept the end-user license agreement (EULA)
    #   for the model. Set to `true` to accept the EULA.
    #   @return [Boolean]
    #
    # @!attribute [rw] endpoint_name
    #   The name of the endpoint. This name must be unique within your
    #   Amazon Web Services account and region.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. This token is listed as not required
    #   because Amazon Web Services SDKs automatically generate it for you
    #   and set this parameter. If you're not using the Amazon Web Services
    #   SDK or the CLI, you must provide this token or the action will fail.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   An array of key-value pairs to apply to the underlying Amazon
    #   SageMaker endpoint. You can use these tags to organize and identify
    #   your Amazon Web Services resources.
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateMarketplaceModelEndpointRequest AWS API Documentation
    #
    class CreateMarketplaceModelEndpointRequest < Struct.new(
      :model_source_identifier,
      :endpoint_config,
      :accept_eula,
      :endpoint_name,
      :client_request_token,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] marketplace_model_endpoint
    #   Details about the created endpoint.
    #   @return [Types::MarketplaceModelEndpoint]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateMarketplaceModelEndpointResponse AWS API Documentation
    #
    class CreateMarketplaceModelEndpointResponse < Struct.new(
      :marketplace_model_endpoint)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] source_model_arn
    #   The Amazon Resource Name (ARN) of the model to be copied.
    #   @return [String]
    #
    # @!attribute [rw] target_model_name
    #   A name for the copied model.
    #   @return [String]
    #
    # @!attribute [rw] model_kms_key_id
    #   The ARN of the KMS key that you use to encrypt the model copy.
    #   @return [String]
    #
    # @!attribute [rw] target_model_tags
    #   Tags to associate with the target model. For more information, see
    #   [Tag resources][1] in the [Amazon Bedrock User Guide][2].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelCopyJobRequest AWS API Documentation
    #
    class CreateModelCopyJobRequest < Struct.new(
      :source_model_arn,
      :target_model_name,
      :model_kms_key_id,
      :target_model_tags,
      :client_request_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the model copy job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelCopyJobResponse AWS API Documentation
    #
    class CreateModelCopyJobResponse < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_name
    #   A name for the fine-tuning job.
    #   @return [String]
    #
    # @!attribute [rw] custom_model_name
    #   A name for the resulting custom model.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of an IAM service role that Amazon
    #   Bedrock can assume to perform tasks on your behalf. For example,
    #   during model training, Amazon Bedrock needs your permission to read
    #   input data from an S3 bucket, write model artifacts to an S3 bucket.
    #   To pass this role to Amazon Bedrock, the caller of this API must
    #   have the `iam:PassRole` permission.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] base_model_identifier
    #   Name of the base model.
    #   @return [String]
    #
    # @!attribute [rw] customization_type
    #   The customization type.
    #   @return [String]
    #
    # @!attribute [rw] custom_model_kms_key_id
    #   The custom model is encrypted at rest using this key.
    #   @return [String]
    #
    # @!attribute [rw] job_tags
    #   Tags to attach to the job.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] custom_model_tags
    #   Tags to attach to the resulting custom model.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] training_data_config
    #   Information about the training dataset.
    #   @return [Types::TrainingDataConfig]
    #
    # @!attribute [rw] validation_data_config
    #   Information about the validation dataset.
    #   @return [Types::ValidationDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   S3 location for the output data.
    #   @return [Types::OutputDataConfig]
    #
    # @!attribute [rw] hyper_parameters
    #   Parameters related to tuning the model. For details on the format
    #   for different models, see [Custom model hyperparameters][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] vpc_config
    #   The configuration of the Virtual Private Cloud (VPC) that contains
    #   the resources that you're using for this job. For more information,
    #   see [Protect your model customization jobs using a VPC][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/vpc-model-customization.html
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] customization_config
    #   The customization configuration for the model customization job.
    #   @return [Types::CustomizationConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelCustomizationJobRequest AWS API Documentation
    #
    class CreateModelCustomizationJobRequest < Struct.new(
      :job_name,
      :custom_model_name,
      :role_arn,
      :client_request_token,
      :base_model_identifier,
      :customization_type,
      :custom_model_kms_key_id,
      :job_tags,
      :custom_model_tags,
      :training_data_config,
      :validation_data_config,
      :output_data_config,
      :hyper_parameters,
      :vpc_config,
      :customization_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   Amazon Resource Name (ARN) of the fine tuning job
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelCustomizationJobResponse AWS API Documentation
    #
    class CreateModelCustomizationJobResponse < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_name
    #   The name of the import job.
    #   @return [String]
    #
    # @!attribute [rw] imported_model_name
    #   The name of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the model import job.
    #   @return [String]
    #
    # @!attribute [rw] model_data_source
    #   The data source for the imported model.
    #   @return [Types::ModelDataSource]
    #
    # @!attribute [rw] job_tags
    #   Tags to attach to this import job.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] imported_model_tags
    #   Tags to attach to the imported model.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] vpc_config
    #   VPC configuration parameters for the private Virtual Private Cloud
    #   (VPC) that contains the resources you are using for the import job.
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] imported_model_kms_key_id
    #   The imported model is encrypted at rest using this key.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelImportJobRequest AWS API Documentation
    #
    class CreateModelImportJobRequest < Struct.new(
      :job_name,
      :imported_model_name,
      :role_arn,
      :model_data_source,
      :job_tags,
      :imported_model_tags,
      :client_request_token,
      :vpc_config,
      :imported_model_kms_key_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the model import job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelImportJobResponse AWS API Documentation
    #
    class CreateModelImportJobResponse < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_name
    #   A name to give the batch inference job.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the service role with permissions
    #   to carry out and manage batch inference. You can use the console to
    #   create a default service role or follow the steps at [Create a
    #   service role for batch inference][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The unique identifier of the foundation model to use for the batch
    #   inference job.
    #   @return [String]
    #
    # @!attribute [rw] input_data_config
    #   Details about the location of the input to the batch inference job.
    #   @return [Types::ModelInvocationJobInputDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   Details about the location of the output of the batch inference job.
    #   @return [Types::ModelInvocationJobOutputDataConfig]
    #
    # @!attribute [rw] vpc_config
    #   The configuration of the Virtual Private Cloud (VPC) for the data in
    #   the batch inference job. For more information, see [Protect batch
    #   inference jobs using a VPC][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] timeout_duration_in_hours
    #   The number of hours after which to force the batch inference job to
    #   time out.
    #   @return [Integer]
    #
    # @!attribute [rw] tags
    #   Any tags to associate with the batch inference job. For more
    #   information, see [Tagging Amazon Bedrock resources][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelInvocationJobRequest AWS API Documentation
    #
    class CreateModelInvocationJobRequest < Struct.new(
      :job_name,
      :role_arn,
      :client_request_token,
      :model_id,
      :input_data_config,
      :output_data_config,
      :vpc_config,
      :timeout_duration_in_hours,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the batch inference job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateModelInvocationJobResponse AWS API Documentation
    #
    class CreateModelInvocationJobResponse < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1] in the
    #   Amazon S3 User Guide.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] model_units
    #   Number of model units to allocate. A model unit delivers a specific
    #   throughput level for the specified model. The throughput level of a
    #   model unit specifies the total number of input and output tokens
    #   that it can process and generate within a span of one minute. By
    #   default, your account has no model units for purchasing Provisioned
    #   Throughputs with commitment. You must first visit the [Amazon Web
    #   Services support center][1] to request MUs.
    #
    #   For model unit quotas, see [Provisioned Throughput quotas][2] in the
    #   [Amazon Bedrock User Guide][3].
    #
    #   For more information about what an MU specifies, contact your Amazon
    #   Web Services account manager.
    #
    #
    #
    #   [1]: https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html#prov-thru-quotas
    #   [3]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [Integer]
    #
    # @!attribute [rw] provisioned_model_name
    #   The name for this Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The Amazon Resource Name (ARN) or name of the model to associate
    #   with this Provisioned Throughput. For a list of models for which you
    #   can purchase Provisioned Throughput, see [Amazon Bedrock model IDs
    #   for purchasing Provisioned Throughput][1] in the [Amazon Bedrock
    #   User Guide][2].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html#prov-throughput-models
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [String]
    #
    # @!attribute [rw] commitment_duration
    #   The commitment duration requested for the Provisioned Throughput.
    #   Billing occurs hourly and is discounted for longer commitment terms.
    #   To request a no-commit Provisioned Throughput, omit this field.
    #
    #   Custom models support all levels of commitment. To see which base
    #   models support no commitment, see [Supported regions and models for
    #   Provisioned Throughput][1] in the [Amazon Bedrock User Guide][2]
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/pt-supported.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   Tags to associate with this Provisioned Throughput.
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateProvisionedModelThroughputRequest AWS API Documentation
    #
    class CreateProvisionedModelThroughputRequest < Struct.new(
      :client_request_token,
      :model_units,
      :provisioned_model_name,
      :model_id,
      :commitment_duration,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] provisioned_model_arn
    #   The Amazon Resource Name (ARN) for this Provisioned Throughput.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CreateProvisionedModelThroughputResponse AWS API Documentation
    #
    class CreateProvisionedModelThroughputResponse < Struct.new(
      :provisioned_model_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # Summary information for a custom model.
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the custom model.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   The name of the custom model.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   Creation time of the model.
    #   @return [Time]
    #
    # @!attribute [rw] base_model_arn
    #   The base model Amazon Resource Name (ARN).
    #   @return [String]
    #
    # @!attribute [rw] base_model_name
    #   The base model name.
    #   @return [String]
    #
    # @!attribute [rw] customization_type
    #   Specifies whether to carry out continued pre-training of a model or
    #   whether to fine-tune it. For more information, see [Custom
    #   models][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html
    #   @return [String]
    #
    # @!attribute [rw] owner_account_id
    #   The unique identifier of the account that owns the model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CustomModelSummary AWS API Documentation
    #
    class CustomModelSummary < Struct.new(
      :model_arn,
      :model_name,
      :creation_time,
      :base_model_arn,
      :base_model_name,
      :customization_type,
      :owner_account_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # A model customization configuration
    #
    # @note CustomizationConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note CustomizationConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of CustomizationConfig corresponding to the set member.
    #
    # @!attribute [rw] distillation_config
    #   The distillation configuration for the custom model.
    #   @return [Types::DistillationConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/CustomizationConfig AWS API Documentation
    #
    class CustomizationConfig < Struct.new(
      :distillation_config,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class DistillationConfig < CustomizationConfig; end
      class Unknown < CustomizationConfig; end
    end

    # @!attribute [rw] model_identifier
    #   Name of the model to delete.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteCustomModelRequest AWS API Documentation
    #
    class DeleteCustomModelRequest < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteCustomModelResponse AWS API Documentation
    #
    class DeleteCustomModelResponse < Aws::EmptyStructure; end

    # @!attribute [rw] guardrail_identifier
    #   The unique identifier of the guardrail. This can be an ID or the
    #   ARN.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_version
    #   The version of the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteGuardrailRequest AWS API Documentation
    #
    class DeleteGuardrailRequest < Struct.new(
      :guardrail_identifier,
      :guardrail_version)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteGuardrailResponse AWS API Documentation
    #
    class DeleteGuardrailResponse < Aws::EmptyStructure; end

    # @!attribute [rw] model_identifier
    #   Name of the imported model to delete.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteImportedModelRequest AWS API Documentation
    #
    class DeleteImportedModelRequest < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteImportedModelResponse AWS API Documentation
    #
    class DeleteImportedModelResponse < Aws::EmptyStructure; end

    # @!attribute [rw] inference_profile_identifier
    #   The Amazon Resource Name (ARN) or ID of the application inference
    #   profile to delete.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteInferenceProfileRequest AWS API Documentation
    #
    class DeleteInferenceProfileRequest < Struct.new(
      :inference_profile_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteInferenceProfileResponse AWS API Documentation
    #
    class DeleteInferenceProfileResponse < Aws::EmptyStructure; end

    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint you want to delete.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteMarketplaceModelEndpointRequest AWS API Documentation
    #
    class DeleteMarketplaceModelEndpointRequest < Struct.new(
      :endpoint_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteMarketplaceModelEndpointResponse AWS API Documentation
    #
    class DeleteMarketplaceModelEndpointResponse < Aws::EmptyStructure; end

    # @api private
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteModelInvocationLoggingConfigurationRequest AWS API Documentation
    #
    class DeleteModelInvocationLoggingConfigurationRequest < Aws::EmptyStructure; end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteModelInvocationLoggingConfigurationResponse AWS API Documentation
    #
    class DeleteModelInvocationLoggingConfigurationResponse < Aws::EmptyStructure; end

    # @!attribute [rw] provisioned_model_id
    #   The Amazon Resource Name (ARN) or name of the Provisioned
    #   Throughput.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteProvisionedModelThroughputRequest AWS API Documentation
    #
    class DeleteProvisionedModelThroughputRequest < Struct.new(
      :provisioned_model_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeleteProvisionedModelThroughputResponse AWS API Documentation
    #
    class DeleteProvisionedModelThroughputResponse < Aws::EmptyStructure; end

    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint you want to
    #   deregister.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeregisterMarketplaceModelEndpointRequest AWS API Documentation
    #
    class DeregisterMarketplaceModelEndpointRequest < Struct.new(
      :endpoint_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DeregisterMarketplaceModelEndpointResponse AWS API Documentation
    #
    class DeregisterMarketplaceModelEndpointResponse < Aws::EmptyStructure; end

    # Settings for distilling a foundation model into a smaller and more
    # efficient model.
    #
    # @!attribute [rw] teacher_model_config
    #   The teacher model configuration.
    #   @return [Types::TeacherModelConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/DistillationConfig AWS API Documentation
    #
    class DistillationConfig < Struct.new(
      :teacher_model_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the configuration for the endpoint.
    #
    # @note EndpointConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EndpointConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EndpointConfig corresponding to the set member.
    #
    # @!attribute [rw] sage_maker
    #   The configuration specific to Amazon SageMaker for the endpoint.
    #   @return [Types::SageMakerEndpoint]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EndpointConfig AWS API Documentation
    #
    class EndpointConfig < Struct.new(
      :sage_maker,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class SageMaker < EndpointConfig; end
      class Unknown < EndpointConfig; end
    end

    # Contains the ARN of the Amazon Bedrock model or [inference profile][1]
    # specified in your evaluation job. Each Amazon Bedrock model supports
    # different `inferenceParams`. To learn more about supported inference
    # parameters for Amazon Bedrock models, see [Inference parameters for
    # foundation models][2].
    #
    # The `inferenceParams` are specified using JSON. To successfully insert
    # JSON as string make sure that all quotations are properly escaped. For
    # example, `"temperature":"0.25"` key value pair would need to be
    # formatted as `"temperature":"0.25"` to successfully accepted in
    # the request.
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html
    # [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html
    #
    # @!attribute [rw] model_identifier
    #   The ARN of the Amazon Bedrock model or inference profile specified.
    #   @return [String]
    #
    # @!attribute [rw] inference_params
    #   Each Amazon Bedrock support different inference parameters that
    #   change how the model behaves during inference.
    #   @return [String]
    #
    # @!attribute [rw] performance_config
    #   Specifies performance settings for the model or inference profile.
    #   @return [Types::PerformanceConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationBedrockModel AWS API Documentation
    #
    class EvaluationBedrockModel < Struct.new(
      :model_identifier,
      :inference_params,
      :performance_config)
      SENSITIVE = [:inference_params]
      include Aws::Structure
    end

    # The configuration details of either an automated or human-based
    # evaluation job.
    #
    # @note EvaluationConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EvaluationConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EvaluationConfig corresponding to the set member.
    #
    # @!attribute [rw] automated
    #   Contains the configuration details of an automated evaluation job
    #   that computes metrics.
    #   @return [Types::AutomatedEvaluationConfig]
    #
    # @!attribute [rw] human
    #   Contains the configuration details of an evaluation job that uses
    #   human workers.
    #   @return [Types::HumanEvaluationConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationConfig AWS API Documentation
    #
    class EvaluationConfig < Struct.new(
      :automated,
      :human,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class Automated < EvaluationConfig; end
      class Human < EvaluationConfig; end
      class Unknown < EvaluationConfig; end
    end

    # Used to specify the name of a built-in prompt dataset and optionally,
    # the Amazon S3 bucket where a custom prompt dataset is saved.
    #
    # @!attribute [rw] name
    #   Used to specify supported built-in prompt datasets. Valid values are
    #   `Builtin.Bold`, `Builtin.BoolQ`, `Builtin.NaturalQuestions`,
    #   `Builtin.Gigaword`, `Builtin.RealToxicityPrompts`,
    #   `Builtin.TriviaQA`, `Builtin.T-Rex`,
    #   `Builtin.WomensEcommerceClothingReviews` and `Builtin.Wikitext2`.
    #   @return [String]
    #
    # @!attribute [rw] dataset_location
    #   For custom prompt datasets, you must specify the location in Amazon
    #   S3 where the prompt dataset is saved.
    #   @return [Types::EvaluationDatasetLocation]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationDataset AWS API Documentation
    #
    class EvaluationDataset < Struct.new(
      :name,
      :dataset_location)
      SENSITIVE = [:name]
      include Aws::Structure
    end

    # The location in Amazon S3 where your prompt dataset is stored.
    #
    # @note EvaluationDatasetLocation is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EvaluationDatasetLocation is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EvaluationDatasetLocation corresponding to the set member.
    #
    # @!attribute [rw] s3_uri
    #   The S3 URI of the S3 bucket specified in the job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationDatasetLocation AWS API Documentation
    #
    class EvaluationDatasetLocation < Struct.new(
      :s3_uri,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class S3Uri < EvaluationDatasetLocation; end
      class Unknown < EvaluationDatasetLocation; end
    end

    # Defines the prompt datasets, built-in metric names and custom metric
    # names, and the task type.
    #
    # @!attribute [rw] task_type
    #   The the type of task you want to evaluate for your evaluation job.
    #   This applies only to model evaluation jobs and is ignored for
    #   knowledge base evaluation jobs.
    #   @return [String]
    #
    # @!attribute [rw] dataset
    #   Specifies the prompt dataset.
    #   @return [Types::EvaluationDataset]
    #
    # @!attribute [rw] metric_names
    #   The names of the metrics you want to use for your evaluation job.
    #
    #   For knowledge base evaluation jobs that evaluate retrieval only,
    #   valid values are "`Builtin.ContextRelevance`",
    #   "`Builtin.ContextConverage`".
    #
    #   For knowledge base evaluation jobs that evaluate retrieval with
    #   response generation, valid values are "`Builtin.Correctness`",
    #   "`Builtin.Completeness`", "`Builtin.Helpfulness`",
    #   "`Builtin.LogicalCoherence`", "`Builtin.Faithfulness`",
    #   "`Builtin.Harmfulness`", "`Builtin.Stereotyping`",
    #   "`Builtin.Refusal`".
    #
    #   For automated model evaluation jobs, valid values are
    #   "`Builtin.Accuracy`", "`Builtin.Robustness`", and
    #   "`Builtin.Toxicity`". In model evaluation jobs that use a LLM as
    #   judge you can specify "`Builtin.Correctness`",
    #   "`Builtin.Completeness"`, "`Builtin.Faithfulness"`,
    #   "`Builtin.Helpfulness`", "`Builtin.Coherence`",
    #   "`Builtin.Relevance`", "`Builtin.FollowingInstructions`",
    #   "`Builtin.ProfessionalStyleAndTone`", You can also specify the
    #   following responsible AI related metrics only for model evaluation
    #   job that use a LLM as judge "`Builtin.Harmfulness`",
    #   "`Builtin.Stereotyping`", and "`Builtin.Refusal`".
    #
    #   For human-based model evaluation jobs, the list of strings must
    #   match the `name` parameter specified in
    #   `HumanEvaluationCustomMetric`.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationDatasetMetricConfig AWS API Documentation
    #
    class EvaluationDatasetMetricConfig < Struct.new(
      :task_type,
      :dataset,
      :metric_names)
      SENSITIVE = [:metric_names]
      include Aws::Structure
    end

    # The configuration details of the inference model for an evaluation
    # job.
    #
    # For automated model evaluation jobs, only a single model is supported.
    #
    # For human-based model evaluation jobs, your annotator can compare the
    # responses for up to two different models.
    #
    # @note EvaluationInferenceConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EvaluationInferenceConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EvaluationInferenceConfig corresponding to the set member.
    #
    # @!attribute [rw] models
    #   Specifies the inference models.
    #   @return [Array<Types::EvaluationModelConfig>]
    #
    # @!attribute [rw] rag_configs
    #   Contains the configuration details of the inference for a knowledge
    #   base evaluation job, including either the retrieval only
    #   configuration or the retrieval with response generation
    #   configuration.
    #   @return [Array<Types::RAGConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationInferenceConfig AWS API Documentation
    #
    class EvaluationInferenceConfig < Struct.new(
      :models,
      :rag_configs,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class Models < EvaluationInferenceConfig; end
      class RagConfigs < EvaluationInferenceConfig; end
      class Unknown < EvaluationInferenceConfig; end
    end

    # Defines the models used in the model evaluation job.
    #
    # @note EvaluationModelConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EvaluationModelConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EvaluationModelConfig corresponding to the set member.
    #
    # @!attribute [rw] bedrock_model
    #   Defines the Amazon Bedrock model or inference profile and inference
    #   parameters you want used.
    #   @return [Types::EvaluationBedrockModel]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationModelConfig AWS API Documentation
    #
    class EvaluationModelConfig < Struct.new(
      :bedrock_model,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class BedrockModel < EvaluationModelConfig; end
      class Unknown < EvaluationModelConfig; end
    end

    # The Amazon S3 location where the results of your evaluation job are
    # saved.
    #
    # @!attribute [rw] s3_uri
    #   The Amazon S3 URI where the results of the evaluation job are saved.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationOutputDataConfig AWS API Documentation
    #
    class EvaluationOutputDataConfig < Struct.new(
      :s3_uri)
      SENSITIVE = []
      include Aws::Structure
    end

    # Summary information of an evaluation job.
    #
    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name for the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time the evaluation job was created.
    #   @return [Time]
    #
    # @!attribute [rw] job_type
    #   Specifies whether the evaluation job is automated or human-based.
    #   @return [String]
    #
    # @!attribute [rw] evaluation_task_types
    #   The type of task for model evaluation.
    #   @return [Array<String>]
    #
    # @!attribute [rw] model_identifiers
    #   The Amazon Resource Names (ARNs) of the model(s) used for the
    #   evaluation job.
    #   @return [Array<String>]
    #
    # @!attribute [rw] rag_identifiers
    #   The Amazon Resource Names (ARNs) of the knowledge base resources
    #   used for a knowledge base evaluation job.
    #   @return [Array<String>]
    #
    # @!attribute [rw] evaluator_model_identifiers
    #   The Amazon Resource Names (ARNs) of the models used to compute the
    #   metrics for a knowledge base evaluation job.
    #   @return [Array<String>]
    #
    # @!attribute [rw] application_type
    #   Specifies whether the evaluation job is for evaluating a model or
    #   evaluating a knowledge base (retrieval and response generation).
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluationSummary AWS API Documentation
    #
    class EvaluationSummary < Struct.new(
      :job_arn,
      :job_name,
      :status,
      :creation_time,
      :job_type,
      :evaluation_task_types,
      :model_identifiers,
      :rag_identifiers,
      :evaluator_model_identifiers,
      :application_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the model configuration for the evaluator model.
    # `EvaluatorModelConfig` is required for evaluation jobs that use a
    # knowledge base or in model evaluation job that use a model as judge.
    # This model computes all evaluation related metrics.
    #
    # @note EvaluatorModelConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note EvaluatorModelConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of EvaluatorModelConfig corresponding to the set member.
    #
    # @!attribute [rw] bedrock_evaluator_models
    #   The evaluator model used in knowledge base evaluation job or in
    #   model evaluation job that use a model as judge. This model computes
    #   all evaluation related metrics.
    #   @return [Array<Types::BedrockEvaluatorModel>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/EvaluatorModelConfig AWS API Documentation
    #
    class EvaluatorModelConfig < Struct.new(
      :bedrock_evaluator_models,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class BedrockEvaluatorModels < EvaluatorModelConfig; end
      class Unknown < EvaluatorModelConfig; end
    end

    # The unique external source of the content contained in the wrapper
    # object.
    #
    # @!attribute [rw] source_type
    #   The source type of the external source wrapper object.
    #   @return [String]
    #
    # @!attribute [rw] s3_location
    #   The S3 location of the external source wrapper object.
    #   @return [Types::S3ObjectDoc]
    #
    # @!attribute [rw] byte_content
    #   The identifier, content type, and data of the external source
    #   wrapper object.
    #   @return [Types::ByteContentDoc]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ExternalSource AWS API Documentation
    #
    class ExternalSource < Struct.new(
      :source_type,
      :s3_location,
      :byte_content)
      SENSITIVE = []
      include Aws::Structure
    end

    # The response generation configuration of the external source wrapper
    # object.
    #
    # @!attribute [rw] prompt_template
    #   Contains the template for the prompt for the external source wrapper
    #   object.
    #   @return [Types::PromptTemplate]
    #
    # @!attribute [rw] guardrail_configuration
    #   Configuration details for the guardrail.
    #   @return [Types::GuardrailConfiguration]
    #
    # @!attribute [rw] kb_inference_config
    #   Configuration details for inference when using `RetrieveAndGenerate`
    #   to generate responses while using an external source.
    #   @return [Types::KbInferenceConfig]
    #
    # @!attribute [rw] additional_model_request_fields
    #   Additional model parameters and their corresponding values not
    #   included in the text inference configuration for an external source.
    #   Takes in custom model parameters specific to the language model
    #   being used.
    #   @return [Hash<String,Hash,Array,String,Numeric,Boolean>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ExternalSourcesGenerationConfiguration AWS API Documentation
    #
    class ExternalSourcesGenerationConfiguration < Struct.new(
      :prompt_template,
      :guardrail_configuration,
      :kb_inference_config,
      :additional_model_request_fields)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration of the external source wrapper object in the
    # `retrieveAndGenerate` function.
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the foundation model or [inference
    #   profile][1] used to generate responses.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html
    #   @return [String]
    #
    # @!attribute [rw] sources
    #   The document for the external source wrapper object in the
    #   `retrieveAndGenerate` function.
    #   @return [Array<Types::ExternalSource>]
    #
    # @!attribute [rw] generation_configuration
    #   Contains configurations details for response generation based on
    #   retrieved text chunks.
    #   @return [Types::ExternalSourcesGenerationConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ExternalSourcesRetrieveAndGenerateConfiguration AWS API Documentation
    #
    class ExternalSourcesRetrieveAndGenerateConfiguration < Struct.new(
      :model_arn,
      :sources,
      :generation_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the name of the metadata attribute/field to apply filters.
    # You must match the name of the attribute/field in your data
    # source/document metadata.
    #
    # @!attribute [rw] key
    #   The name of metadata attribute/field, which must match the name in
    #   your data source/document metadata.
    #   @return [String]
    #
    # @!attribute [rw] value
    #   The value of the metadata attribute/field.
    #   @return [Hash,Array,String,Numeric,Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/FilterAttribute AWS API Documentation
    #
    class FilterAttribute < Struct.new(
      :key,
      :value)
      SENSITIVE = []
      include Aws::Structure
    end

    # Information about a foundation model.
    #
    # @!attribute [rw] model_arn
    #   The model Amazon Resource Name (ARN).
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The model identifier.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   The model name.
    #   @return [String]
    #
    # @!attribute [rw] provider_name
    #   The model's provider name.
    #   @return [String]
    #
    # @!attribute [rw] input_modalities
    #   The input modalities that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] output_modalities
    #   The output modalities that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] response_streaming_supported
    #   Indicates whether the model supports streaming.
    #   @return [Boolean]
    #
    # @!attribute [rw] customizations_supported
    #   The customization that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] inference_types_supported
    #   The inference types that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] model_lifecycle
    #   Contains details about whether a model version is available or
    #   deprecated
    #   @return [Types::FoundationModelLifecycle]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/FoundationModelDetails AWS API Documentation
    #
    class FoundationModelDetails < Struct.new(
      :model_arn,
      :model_id,
      :model_name,
      :provider_name,
      :input_modalities,
      :output_modalities,
      :response_streaming_supported,
      :customizations_supported,
      :inference_types_supported,
      :model_lifecycle)
      SENSITIVE = []
      include Aws::Structure
    end

    # Details about whether a model version is available or deprecated.
    #
    # @!attribute [rw] status
    #   Specifies whether a model version is available (`ACTIVE`) or
    #   deprecated (`LEGACY`.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/FoundationModelLifecycle AWS API Documentation
    #
    class FoundationModelLifecycle < Struct.new(
      :status)
      SENSITIVE = []
      include Aws::Structure
    end

    # Summary information for a foundation model.
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the foundation model.
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The model ID of the foundation model.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   The name of the model.
    #   @return [String]
    #
    # @!attribute [rw] provider_name
    #   The model's provider name.
    #   @return [String]
    #
    # @!attribute [rw] input_modalities
    #   The input modalities that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] output_modalities
    #   The output modalities that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] response_streaming_supported
    #   Indicates whether the model supports streaming.
    #   @return [Boolean]
    #
    # @!attribute [rw] customizations_supported
    #   Whether the model supports fine-tuning or continual pre-training.
    #   @return [Array<String>]
    #
    # @!attribute [rw] inference_types_supported
    #   The inference types that the model supports.
    #   @return [Array<String>]
    #
    # @!attribute [rw] model_lifecycle
    #   Contains details about whether a model version is available or
    #   deprecated.
    #   @return [Types::FoundationModelLifecycle]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/FoundationModelSummary AWS API Documentation
    #
    class FoundationModelSummary < Struct.new(
      :model_arn,
      :model_id,
      :model_name,
      :provider_name,
      :input_modalities,
      :output_modalities,
      :response_streaming_supported,
      :customizations_supported,
      :inference_types_supported,
      :model_lifecycle)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for response generation based on retrieved
    # text chunks.
    #
    # @!attribute [rw] prompt_template
    #   Contains the template for the prompt that's sent to the model for
    #   response generation.
    #   @return [Types::PromptTemplate]
    #
    # @!attribute [rw] guardrail_configuration
    #   Contains configuration details for the guardrail.
    #   @return [Types::GuardrailConfiguration]
    #
    # @!attribute [rw] kb_inference_config
    #   Contains configuration details for inference for knowledge base
    #   retrieval and response generation.
    #   @return [Types::KbInferenceConfig]
    #
    # @!attribute [rw] additional_model_request_fields
    #   Additional model parameters and corresponding values not included in
    #   the `textInferenceConfig` structure for a knowledge base. This
    #   allows you to provide custom model parameters specific to the
    #   language model being used.
    #   @return [Hash<String,Hash,Array,String,Numeric,Boolean>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GenerationConfiguration AWS API Documentation
    #
    class GenerationConfiguration < Struct.new(
      :prompt_template,
      :guardrail_configuration,
      :kb_inference_config,
      :additional_model_request_fields)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_identifier
    #   Name or Amazon Resource Name (ARN) of the custom model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetCustomModelRequest AWS API Documentation
    #
    class GetCustomModelRequest < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_arn
    #   Amazon Resource Name (ARN) associated with this model.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   Model name associated with this model.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   Job name associated with this model.
    #   @return [String]
    #
    # @!attribute [rw] job_arn
    #   Job Amazon Resource Name (ARN) associated with this model.
    #   @return [String]
    #
    # @!attribute [rw] base_model_arn
    #   Amazon Resource Name (ARN) of the base model.
    #   @return [String]
    #
    # @!attribute [rw] customization_type
    #   The type of model customization.
    #   @return [String]
    #
    # @!attribute [rw] model_kms_key_arn
    #   The custom model is encrypted at rest using this key.
    #   @return [String]
    #
    # @!attribute [rw] hyper_parameters
    #   Hyperparameter values associated with this model. For details on the
    #   format for different models, see [Custom model hyperparameters][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] training_data_config
    #   Contains information about the training dataset.
    #   @return [Types::TrainingDataConfig]
    #
    # @!attribute [rw] validation_data_config
    #   Contains information about the validation dataset.
    #   @return [Types::ValidationDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   Output data configuration associated with this custom model.
    #   @return [Types::OutputDataConfig]
    #
    # @!attribute [rw] training_metrics
    #   Contains training metrics from the job creation.
    #   @return [Types::TrainingMetrics]
    #
    # @!attribute [rw] validation_metrics
    #   The validation metrics from the job creation.
    #   @return [Array<Types::ValidatorMetric>]
    #
    # @!attribute [rw] creation_time
    #   Creation time of the model.
    #   @return [Time]
    #
    # @!attribute [rw] customization_config
    #   The customization configuration for the custom model.
    #   @return [Types::CustomizationConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetCustomModelResponse AWS API Documentation
    #
    class GetCustomModelResponse < Struct.new(
      :model_arn,
      :model_name,
      :job_name,
      :job_arn,
      :base_model_arn,
      :customization_type,
      :model_kms_key_arn,
      :hyper_parameters,
      :training_data_config,
      :validation_data_config,
      :output_data_config,
      :training_metrics,
      :validation_metrics,
      :creation_time,
      :customization_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_identifier
    #   The Amazon Resource Name (ARN) of the evaluation job you want get
    #   information on.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetEvaluationJobRequest AWS API Documentation
    #
    class GetEvaluationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = [:job_identifier]
      include Aws::Structure
    end

    # @!attribute [rw] job_name
    #   The name for the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The current status of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] job_description
    #   The description of the evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the IAM service role used in the
    #   evaluation job.
    #   @return [String]
    #
    # @!attribute [rw] customer_encryption_key_id
    #   The Amazon Resource Name (ARN) of the customer managed encryption
    #   key specified when the evaluation job was created.
    #   @return [String]
    #
    # @!attribute [rw] job_type
    #   Specifies whether the evaluation job is automated or human-based.
    #   @return [String]
    #
    # @!attribute [rw] application_type
    #   Specifies whether the evaluation job is for evaluating a model or
    #   evaluating a knowledge base (retrieval and response generation).
    #   @return [String]
    #
    # @!attribute [rw] evaluation_config
    #   Contains the configuration details of either an automated or
    #   human-based evaluation job.
    #   @return [Types::EvaluationConfig]
    #
    # @!attribute [rw] inference_config
    #   Contains the configuration details of the inference model used for
    #   the evaluation job.
    #   @return [Types::EvaluationInferenceConfig]
    #
    # @!attribute [rw] output_data_config
    #   Contains the configuration details of the Amazon S3 bucket for
    #   storing the results of the evaluation job.
    #   @return [Types::EvaluationOutputDataConfig]
    #
    # @!attribute [rw] creation_time
    #   The time the evaluation job was created.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   The time the evaluation job was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] failure_messages
    #   A list of strings that specify why the evaluation job failed to
    #   create.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetEvaluationJobResponse AWS API Documentation
    #
    class GetEvaluationJobResponse < Struct.new(
      :job_name,
      :status,
      :job_arn,
      :job_description,
      :role_arn,
      :customer_encryption_key_id,
      :job_type,
      :application_type,
      :evaluation_config,
      :inference_config,
      :output_data_config,
      :creation_time,
      :last_modified_time,
      :failure_messages)
      SENSITIVE = [:job_description]
      include Aws::Structure
    end

    # @!attribute [rw] model_identifier
    #   The model identifier.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetFoundationModelRequest AWS API Documentation
    #
    class GetFoundationModelRequest < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_details
    #   Information about the foundation model.
    #   @return [Types::FoundationModelDetails]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetFoundationModelResponse AWS API Documentation
    #
    class GetFoundationModelResponse < Struct.new(
      :model_details)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_identifier
    #   The unique identifier of the guardrail for which to get details.
    #   This can be an ID or the ARN.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_version
    #   The version of the guardrail for which to get details. If you don't
    #   specify a version, the response returns details for the `DRAFT`
    #   version.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetGuardrailRequest AWS API Documentation
    #
    class GetGuardrailRequest < Struct.new(
      :guardrail_identifier,
      :guardrail_version)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] name
    #   The name of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_id
    #   The unique identifier of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_arn
    #   The ARN of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   The version of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] topic_policy
    #   The topic policy that was configured for the guardrail.
    #   @return [Types::GuardrailTopicPolicy]
    #
    # @!attribute [rw] content_policy
    #   The content policy that was configured for the guardrail.
    #   @return [Types::GuardrailContentPolicy]
    #
    # @!attribute [rw] word_policy
    #   The word policy that was configured for the guardrail.
    #   @return [Types::GuardrailWordPolicy]
    #
    # @!attribute [rw] sensitive_information_policy
    #   The sensitive information policy that was configured for the
    #   guardrail.
    #   @return [Types::GuardrailSensitiveInformationPolicy]
    #
    # @!attribute [rw] contextual_grounding_policy
    #   The contextual grounding policy used in the guardrail.
    #   @return [Types::GuardrailContextualGroundingPolicy]
    #
    # @!attribute [rw] created_at
    #   The date and time at which the guardrail was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The date and time at which the guardrail was updated.
    #   @return [Time]
    #
    # @!attribute [rw] status_reasons
    #   Appears if the `status` is `FAILED`. A list of reasons for why the
    #   guardrail failed to be created, updated, versioned, or deleted.
    #   @return [Array<String>]
    #
    # @!attribute [rw] failure_recommendations
    #   Appears if the `status` of the guardrail is `FAILED`. A list of
    #   recommendations to carry out before retrying the request.
    #   @return [Array<String>]
    #
    # @!attribute [rw] blocked_input_messaging
    #   The message that the guardrail returns when it blocks a prompt.
    #   @return [String]
    #
    # @!attribute [rw] blocked_outputs_messaging
    #   The message that the guardrail returns when it blocks a model
    #   response.
    #   @return [String]
    #
    # @!attribute [rw] kms_key_arn
    #   The ARN of the KMS key that encrypts the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetGuardrailResponse AWS API Documentation
    #
    class GetGuardrailResponse < Struct.new(
      :name,
      :description,
      :guardrail_id,
      :guardrail_arn,
      :version,
      :status,
      :topic_policy,
      :content_policy,
      :word_policy,
      :sensitive_information_policy,
      :contextual_grounding_policy,
      :created_at,
      :updated_at,
      :status_reasons,
      :failure_recommendations,
      :blocked_input_messaging,
      :blocked_outputs_messaging,
      :kms_key_arn)
      SENSITIVE = [:name, :description, :status_reasons, :failure_recommendations, :blocked_input_messaging, :blocked_outputs_messaging]
      include Aws::Structure
    end

    # @!attribute [rw] model_identifier
    #   Name or Amazon Resource Name (ARN) of the imported model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetImportedModelRequest AWS API Documentation
    #
    class GetImportedModelRequest < Struct.new(
      :model_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) associated with this imported model.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   The name of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   Job name associated with the imported model.
    #   @return [String]
    #
    # @!attribute [rw] job_arn
    #   Job Amazon Resource Name (ARN) associated with the imported model.
    #   @return [String]
    #
    # @!attribute [rw] model_data_source
    #   The data source for this imported model.
    #   @return [Types::ModelDataSource]
    #
    # @!attribute [rw] creation_time
    #   Creation time of the imported model.
    #   @return [Time]
    #
    # @!attribute [rw] model_architecture
    #   The architecture of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] model_kms_key_arn
    #   The imported model is encrypted at rest using this key.
    #   @return [String]
    #
    # @!attribute [rw] instruct_supported
    #   Specifies if the imported model supports converse.
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetImportedModelResponse AWS API Documentation
    #
    class GetImportedModelResponse < Struct.new(
      :model_arn,
      :model_name,
      :job_name,
      :job_arn,
      :model_data_source,
      :creation_time,
      :model_architecture,
      :model_kms_key_arn,
      :instruct_supported)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] inference_profile_identifier
    #   The ID or Amazon Resource Name (ARN) of the inference profile.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetInferenceProfileRequest AWS API Documentation
    #
    class GetInferenceProfileRequest < Struct.new(
      :inference_profile_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] inference_profile_name
    #   The name of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The time at which the inference profile was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The time at which the inference profile was last updated.
    #   @return [Time]
    #
    # @!attribute [rw] inference_profile_arn
    #   The Amazon Resource Name (ARN) of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] models
    #   A list of information about each model in the inference profile.
    #   @return [Array<Types::InferenceProfileModel>]
    #
    # @!attribute [rw] inference_profile_id
    #   The unique identifier of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the inference profile. `ACTIVE` means that the
    #   inference profile is ready to be used.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the inference profile. The following types are possible:
    #
    #   * `SYSTEM_DEFINED` – The inference profile is defined by Amazon
    #     Bedrock. You can route inference requests across regions with
    #     these inference profiles.
    #
    #   * `APPLICATION` – The inference profile was created by a user. This
    #     type of inference profile can track metrics and costs when
    #     invoking the model in it. The inference profile may route requests
    #     to one or multiple regions.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetInferenceProfileResponse AWS API Documentation
    #
    class GetInferenceProfileResponse < Struct.new(
      :inference_profile_name,
      :description,
      :created_at,
      :updated_at,
      :inference_profile_arn,
      :models,
      :inference_profile_id,
      :status,
      :type)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint you want to get
    #   information about.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetMarketplaceModelEndpointRequest AWS API Documentation
    #
    class GetMarketplaceModelEndpointRequest < Struct.new(
      :endpoint_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] marketplace_model_endpoint
    #   Details about the requested endpoint.
    #   @return [Types::MarketplaceModelEndpoint]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetMarketplaceModelEndpointResponse AWS API Documentation
    #
    class GetMarketplaceModelEndpointResponse < Struct.new(
      :marketplace_model_endpoint)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the model copy job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelCopyJobRequest AWS API Documentation
    #
    class GetModelCopyJobRequest < Struct.new(
      :job_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the model copy job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the model copy job.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time at which the model copy job was created.
    #   @return [Time]
    #
    # @!attribute [rw] target_model_arn
    #   The Amazon Resource Name (ARN) of the copied model.
    #   @return [String]
    #
    # @!attribute [rw] target_model_name
    #   The name of the copied model.
    #   @return [String]
    #
    # @!attribute [rw] source_account_id
    #   The unique identifier of the account that the model being copied
    #   originated from.
    #   @return [String]
    #
    # @!attribute [rw] source_model_arn
    #   The Amazon Resource Name (ARN) of the original model being copied.
    #   @return [String]
    #
    # @!attribute [rw] target_model_kms_key_arn
    #   The Amazon Resource Name (ARN) of the KMS key encrypting the copied
    #   model.
    #   @return [String]
    #
    # @!attribute [rw] target_model_tags
    #   The tags associated with the copied model.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] failure_message
    #   An error message for why the model copy job failed.
    #   @return [String]
    #
    # @!attribute [rw] source_model_name
    #   The name of the original model being copied.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelCopyJobResponse AWS API Documentation
    #
    class GetModelCopyJobResponse < Struct.new(
      :job_arn,
      :status,
      :creation_time,
      :target_model_arn,
      :target_model_name,
      :source_account_id,
      :source_model_arn,
      :target_model_kms_key_arn,
      :target_model_tags,
      :failure_message,
      :source_model_name)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_identifier
    #   Identifier for the customization job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelCustomizationJobRequest AWS API Documentation
    #
    class GetModelCustomizationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the customization job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name of the customization job.
    #   @return [String]
    #
    # @!attribute [rw] output_model_name
    #   The name of the output model.
    #   @return [String]
    #
    # @!attribute [rw] output_model_arn
    #   The Amazon Resource Name (ARN) of the output model.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   The token that you specified in the `CreateCustomizationJob`
    #   request.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the IAM role.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the job. A successful job transitions from in-progress
    #   to completed when the output model is ready to use. If the job
    #   failed, the failure message contains information about why the job
    #   failed.
    #   @return [String]
    #
    # @!attribute [rw] failure_message
    #   Information about why the job failed.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   Time that the resource was created.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   Time that the resource was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   Time that the resource transitioned to terminal state.
    #   @return [Time]
    #
    # @!attribute [rw] base_model_arn
    #   Amazon Resource Name (ARN) of the base model.
    #   @return [String]
    #
    # @!attribute [rw] hyper_parameters
    #   The hyperparameter values for the job. For details on the format for
    #   different models, see [Custom model hyperparameters][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] training_data_config
    #   Contains information about the training dataset.
    #   @return [Types::TrainingDataConfig]
    #
    # @!attribute [rw] validation_data_config
    #   Contains information about the validation dataset.
    #   @return [Types::ValidationDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   Output data configuration
    #   @return [Types::OutputDataConfig]
    #
    # @!attribute [rw] customization_type
    #   The type of model customization.
    #   @return [String]
    #
    # @!attribute [rw] output_model_kms_key_arn
    #   The custom model is encrypted at rest using this key.
    #   @return [String]
    #
    # @!attribute [rw] training_metrics
    #   Contains training metrics from the job creation.
    #   @return [Types::TrainingMetrics]
    #
    # @!attribute [rw] validation_metrics
    #   The loss metric for each validator that you provided in the
    #   createjob request.
    #   @return [Array<Types::ValidatorMetric>]
    #
    # @!attribute [rw] vpc_config
    #   VPC configuration for the custom model job.
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] customization_config
    #   The customization configuration for the model customization job.
    #   @return [Types::CustomizationConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelCustomizationJobResponse AWS API Documentation
    #
    class GetModelCustomizationJobResponse < Struct.new(
      :job_arn,
      :job_name,
      :output_model_name,
      :output_model_arn,
      :client_request_token,
      :role_arn,
      :status,
      :failure_message,
      :creation_time,
      :last_modified_time,
      :end_time,
      :base_model_arn,
      :hyper_parameters,
      :training_data_config,
      :validation_data_config,
      :output_data_config,
      :customization_type,
      :output_model_kms_key_arn,
      :training_metrics,
      :validation_metrics,
      :vpc_config,
      :customization_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_identifier
    #   The identifier of the import job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelImportJobRequest AWS API Documentation
    #
    class GetModelImportJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the import job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name of the import job.
    #   @return [String]
    #
    # @!attribute [rw] imported_model_name
    #   The name of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] imported_model_arn
    #   The Amazon Resource Name (ARN) of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the IAM role associated with this
    #   job.
    #   @return [String]
    #
    # @!attribute [rw] model_data_source
    #   The data source for the imported model.
    #   @return [Types::ModelDataSource]
    #
    # @!attribute [rw] status
    #   The status of the job. A successful job transitions from in-progress
    #   to completed when the imported model is ready to use. If the job
    #   failed, the failure message contains information about why the job
    #   failed.
    #   @return [String]
    #
    # @!attribute [rw] failure_message
    #   Information about why the import job failed.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time the resource was created.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   Time the resource was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   Time that the resource transitioned to terminal state.
    #   @return [Time]
    #
    # @!attribute [rw] vpc_config
    #   The Virtual Private Cloud (VPC) configuration of the import model
    #   job.
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] imported_model_kms_key_arn
    #   The imported model is encrypted at rest using this key.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelImportJobResponse AWS API Documentation
    #
    class GetModelImportJobResponse < Struct.new(
      :job_arn,
      :job_name,
      :imported_model_name,
      :imported_model_arn,
      :role_arn,
      :model_data_source,
      :status,
      :failure_message,
      :creation_time,
      :last_modified_time,
      :end_time,
      :vpc_config,
      :imported_model_kms_key_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_identifier
    #   The Amazon Resource Name (ARN) of the batch inference job.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelInvocationJobRequest AWS API Documentation
    #
    class GetModelInvocationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the batch inference job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name of the batch inference job.
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The unique identifier of the foundation model used for model
    #   inference.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the service role with permissions
    #   to carry out and manage batch inference. You can use the console to
    #   create a default service role or follow the steps at [Create a
    #   service role for batch inference][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the batch inference job.
    #
    #   The following statuses are possible:
    #
    #   * Submitted – This job has been submitted to a queue for validation.
    #
    #   * Validating – This job is being validated for the requirements
    #     described in [Format and upload your batch inference data][1]. The
    #     criteria include the following:
    #
    #     * Your IAM service role has access to the Amazon S3 buckets
    #       containing your files.
    #
    #     * Your files are .jsonl files and each individual record is a JSON
    #       object in the correct format. Note that validation doesn't
    #       check if the `modelInput` value matches the request body for the
    #       model.
    #
    #     * Your files fulfill the requirements for file size and number of
    #       records. For more information, see [Quotas for Amazon
    #       Bedrock][2].
    #   * Scheduled – This job has been validated and is now in a queue. The
    #     job will automatically start when it reaches its turn.
    #
    #   * Expired – This job timed out because it was scheduled but didn't
    #     begin before the set timeout duration. Submit a new job request.
    #
    #   * InProgress – This job has begun. You can start viewing the results
    #     in the output S3 location.
    #
    #   * Completed – This job has successfully completed. View the output
    #     files in the output S3 location.
    #
    #   * PartiallyCompleted – This job has partially completed. Not all of
    #     your records could be processed in time. View the output files in
    #     the output S3 location.
    #
    #   * Failed – This job has failed. Check the failure message for any
    #     further details. For further assistance, reach out to the [Amazon
    #     Web Services Support Center][3].
    #
    #   * Stopped – This job was stopped by a user.
    #
    #   * Stopping – This job is being stopped by a user.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html
    #   [3]: https://console.aws.amazon.com/support/home/
    #   @return [String]
    #
    # @!attribute [rw] message
    #   If the batch inference job failed, this field contains a message
    #   describing why the job failed.
    #   @return [String]
    #
    # @!attribute [rw] submit_time
    #   The time at which the batch inference job was submitted.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   The time at which the batch inference job was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   The time at which the batch inference job ended.
    #   @return [Time]
    #
    # @!attribute [rw] input_data_config
    #   Details about the location of the input to the batch inference job.
    #   @return [Types::ModelInvocationJobInputDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   Details about the location of the output of the batch inference job.
    #   @return [Types::ModelInvocationJobOutputDataConfig]
    #
    # @!attribute [rw] vpc_config
    #   The configuration of the Virtual Private Cloud (VPC) for the data in
    #   the batch inference job. For more information, see [Protect batch
    #   inference jobs using a VPC][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] timeout_duration_in_hours
    #   The number of hours after which batch inference job was set to time
    #   out.
    #   @return [Integer]
    #
    # @!attribute [rw] job_expiration_time
    #   The time at which the batch inference job times or timed out.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelInvocationJobResponse AWS API Documentation
    #
    class GetModelInvocationJobResponse < Struct.new(
      :job_arn,
      :job_name,
      :model_id,
      :client_request_token,
      :role_arn,
      :status,
      :message,
      :submit_time,
      :last_modified_time,
      :end_time,
      :input_data_config,
      :output_data_config,
      :vpc_config,
      :timeout_duration_in_hours,
      :job_expiration_time)
      SENSITIVE = [:message]
      include Aws::Structure
    end

    # @api private
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelInvocationLoggingConfigurationRequest AWS API Documentation
    #
    class GetModelInvocationLoggingConfigurationRequest < Aws::EmptyStructure; end

    # @!attribute [rw] logging_config
    #   The current configuration values.
    #   @return [Types::LoggingConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetModelInvocationLoggingConfigurationResponse AWS API Documentation
    #
    class GetModelInvocationLoggingConfigurationResponse < Struct.new(
      :logging_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] prompt_router_arn
    #   The prompt router's ARN
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetPromptRouterRequest AWS API Documentation
    #
    class GetPromptRouterRequest < Struct.new(
      :prompt_router_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] prompt_router_name
    #   The router's name.
    #   @return [String]
    #
    # @!attribute [rw] routing_criteria
    #   The router's routing criteria.
    #   @return [Types::RoutingCriteria]
    #
    # @!attribute [rw] description
    #   The router's description.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   When the router was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   When the router was updated.
    #   @return [Time]
    #
    # @!attribute [rw] prompt_router_arn
    #   The prompt router's ARN
    #   @return [String]
    #
    # @!attribute [rw] models
    #   The router's models.
    #   @return [Array<Types::PromptRouterTargetModel>]
    #
    # @!attribute [rw] fallback_model
    #   The router's fallback model.
    #   @return [Types::PromptRouterTargetModel]
    #
    # @!attribute [rw] status
    #   The router's status.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The router's type.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetPromptRouterResponse AWS API Documentation
    #
    class GetPromptRouterResponse < Struct.new(
      :prompt_router_name,
      :routing_criteria,
      :description,
      :created_at,
      :updated_at,
      :prompt_router_arn,
      :models,
      :fallback_model,
      :status,
      :type)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # @!attribute [rw] provisioned_model_id
    #   The Amazon Resource Name (ARN) or name of the Provisioned
    #   Throughput.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetProvisionedModelThroughputRequest AWS API Documentation
    #
    class GetProvisionedModelThroughputRequest < Struct.new(
      :provisioned_model_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_units
    #   The number of model units allocated to this Provisioned Throughput.
    #   @return [Integer]
    #
    # @!attribute [rw] desired_model_units
    #   The number of model units that was requested for this Provisioned
    #   Throughput.
    #   @return [Integer]
    #
    # @!attribute [rw] provisioned_model_name
    #   The name of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] provisioned_model_arn
    #   The Amazon Resource Name (ARN) of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the model associated with this
    #   Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] desired_model_arn
    #   The Amazon Resource Name (ARN) of the model requested to be
    #   associated to this Provisioned Throughput. This value differs from
    #   the `modelArn` if updating hasn't completed.
    #   @return [String]
    #
    # @!attribute [rw] foundation_model_arn
    #   The Amazon Resource Name (ARN) of the base model for which the
    #   Provisioned Throughput was created, or of the base model that the
    #   custom model for which the Provisioned Throughput was created was
    #   customized.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The timestamp of the creation time for this Provisioned Throughput.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   The timestamp of the last time that this Provisioned Throughput was
    #   modified.
    #   @return [Time]
    #
    # @!attribute [rw] failure_message
    #   A failure message for any issues that occurred during creation,
    #   updating, or deletion of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] commitment_duration
    #   Commitment duration of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] commitment_expiration_time
    #   The timestamp for when the commitment term for the Provisioned
    #   Throughput expires.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GetProvisionedModelThroughputResponse AWS API Documentation
    #
    class GetProvisionedModelThroughputResponse < Struct.new(
      :model_units,
      :desired_model_units,
      :provisioned_model_name,
      :provisioned_model_arn,
      :model_arn,
      :desired_model_arn,
      :foundation_model_arn,
      :status,
      :creation_time,
      :last_modified_time,
      :failure_message,
      :commitment_duration,
      :commitment_expiration_time)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for the guardrail.
    #
    # @!attribute [rw] guardrail_id
    #   The unique identifier for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] guardrail_version
    #   The version of the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailConfiguration AWS API Documentation
    #
    class GuardrailConfiguration < Struct.new(
      :guardrail_id,
      :guardrail_version)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains filter strengths for harmful content. Guardrails support the
    # following content filters to detect and filter harmful user inputs and
    # FM-generated outputs.
    #
    # * **Hate** – Describes language or a statement that discriminates,
    #   criticizes, insults, denounces, or dehumanizes a person or group on
    #   the basis of an identity (such as race, ethnicity, gender, religion,
    #   sexual orientation, ability, and national origin).
    #
    # * **Insults** – Describes language or a statement that includes
    #   demeaning, humiliating, mocking, insulting, or belittling language.
    #   This type of language is also labeled as bullying.
    #
    # * **Sexual** – Describes language or a statement that indicates sexual
    #   interest, activity, or arousal using direct or indirect references
    #   to body parts, physical traits, or sex.
    #
    # * **Violence** – Describes language or a statement that includes
    #   glorification of or threats to inflict physical pain, hurt, or
    #   injury toward a person, group or thing.
    #
    # Content filtering depends on the confidence classification of user
    # inputs and FM responses across each of the four harmful categories.
    # All input and output statements are classified into one of four
    # confidence levels (NONE, LOW, MEDIUM, HIGH) for each harmful category.
    # For example, if a statement is classified as *Hate* with HIGH
    # confidence, the likelihood of the statement representing hateful
    # content is high. A single statement can be classified across multiple
    # categories with varying confidence levels. For example, a single
    # statement can be classified as *Hate* with HIGH confidence, *Insults*
    # with LOW confidence, *Sexual* with NONE confidence, and *Violence*
    # with MEDIUM confidence.
    #
    # For more information, see [Guardrails content filters][1].
    #
    # This data type is used in the following API operations:
    #
    # * [GetGuardrail response body][2]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-filters.html
    # [2]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax
    #
    # @!attribute [rw] type
    #   The harmful category that the content filter is applied to.
    #   @return [String]
    #
    # @!attribute [rw] input_strength
    #   The strength of the content filter to apply to prompts. As you
    #   increase the filter strength, the likelihood of filtering harmful
    #   content increases and the probability of seeing harmful content in
    #   your application reduces.
    #   @return [String]
    #
    # @!attribute [rw] output_strength
    #   The strength of the content filter to apply to model responses. As
    #   you increase the filter strength, the likelihood of filtering
    #   harmful content increases and the probability of seeing harmful
    #   content in your application reduces.
    #   @return [String]
    #
    # @!attribute [rw] input_modalities
    #   The input modalities selected for the guardrail content filter.
    #   @return [Array<String>]
    #
    # @!attribute [rw] output_modalities
    #   The output modalities selected for the guardrail content filter.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContentFilter AWS API Documentation
    #
    class GuardrailContentFilter < Struct.new(
      :type,
      :input_strength,
      :output_strength,
      :input_modalities,
      :output_modalities)
      SENSITIVE = [:input_modalities, :output_modalities]
      include Aws::Structure
    end

    # Contains filter strengths for harmful content. Guardrails support the
    # following content filters to detect and filter harmful user inputs and
    # FM-generated outputs.
    #
    # * **Hate** – Describes language or a statement that discriminates,
    #   criticizes, insults, denounces, or dehumanizes a person or group on
    #   the basis of an identity (such as race, ethnicity, gender, religion,
    #   sexual orientation, ability, and national origin).
    #
    # * **Insults** – Describes language or a statement that includes
    #   demeaning, humiliating, mocking, insulting, or belittling language.
    #   This type of language is also labeled as bullying.
    #
    # * **Sexual** – Describes language or a statement that indicates sexual
    #   interest, activity, or arousal using direct or indirect references
    #   to body parts, physical traits, or sex.
    #
    # * **Violence** – Describes language or a statement that includes
    #   glorification of or threats to inflict physical pain, hurt, or
    #   injury toward a person, group or thing.
    #
    # Content filtering depends on the confidence classification of user
    # inputs and FM responses across each of the four harmful categories.
    # All input and output statements are classified into one of four
    # confidence levels (NONE, LOW, MEDIUM, HIGH) for each harmful category.
    # For example, if a statement is classified as *Hate* with HIGH
    # confidence, the likelihood of the statement representing hateful
    # content is high. A single statement can be classified across multiple
    # categories with varying confidence levels. For example, a single
    # statement can be classified as *Hate* with HIGH confidence, *Insults*
    # with LOW confidence, *Sexual* with NONE confidence, and *Violence*
    # with MEDIUM confidence.
    #
    # For more information, see [Guardrails content filters][1].
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-filters.html
    #
    # @!attribute [rw] type
    #   The harmful category that the content filter is applied to.
    #   @return [String]
    #
    # @!attribute [rw] input_strength
    #   The strength of the content filter to apply to prompts. As you
    #   increase the filter strength, the likelihood of filtering harmful
    #   content increases and the probability of seeing harmful content in
    #   your application reduces.
    #   @return [String]
    #
    # @!attribute [rw] output_strength
    #   The strength of the content filter to apply to model responses. As
    #   you increase the filter strength, the likelihood of filtering
    #   harmful content increases and the probability of seeing harmful
    #   content in your application reduces.
    #   @return [String]
    #
    # @!attribute [rw] input_modalities
    #   The input modalities selected for the guardrail content filter
    #   configuration.
    #   @return [Array<String>]
    #
    # @!attribute [rw] output_modalities
    #   The output modalities selected for the guardrail content filter
    #   configuration.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContentFilterConfig AWS API Documentation
    #
    class GuardrailContentFilterConfig < Struct.new(
      :type,
      :input_strength,
      :output_strength,
      :input_modalities,
      :output_modalities)
      SENSITIVE = [:input_modalities, :output_modalities]
      include Aws::Structure
    end

    # Contains details about how to handle harmful content.
    #
    # This data type is used in the following API operations:
    #
    # * [GetGuardrail response body][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax
    #
    # @!attribute [rw] filters
    #   Contains the type of the content filter and how strongly it should
    #   apply to prompts and model responses.
    #   @return [Array<Types::GuardrailContentFilter>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContentPolicy AWS API Documentation
    #
    class GuardrailContentPolicy < Struct.new(
      :filters)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about how to handle harmful content.
    #
    # @!attribute [rw] filters_config
    #   Contains the type of the content filter and how strongly it should
    #   apply to prompts and model responses.
    #   @return [Array<Types::GuardrailContentFilterConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContentPolicyConfig AWS API Documentation
    #
    class GuardrailContentPolicyConfig < Struct.new(
      :filters_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # The details for the guardrails contextual grounding filter.
    #
    # @!attribute [rw] type
    #   The filter type details for the guardrails contextual grounding
    #   filter.
    #   @return [String]
    #
    # @!attribute [rw] threshold
    #   The threshold details for the guardrails contextual grounding
    #   filter.
    #   @return [Float]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContextualGroundingFilter AWS API Documentation
    #
    class GuardrailContextualGroundingFilter < Struct.new(
      :type,
      :threshold)
      SENSITIVE = []
      include Aws::Structure
    end

    # The filter configuration details for the guardrails contextual
    # grounding filter.
    #
    # @!attribute [rw] type
    #   The filter details for the guardrails contextual grounding filter.
    #   @return [String]
    #
    # @!attribute [rw] threshold
    #   The threshold details for the guardrails contextual grounding
    #   filter.
    #   @return [Float]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContextualGroundingFilterConfig AWS API Documentation
    #
    class GuardrailContextualGroundingFilterConfig < Struct.new(
      :type,
      :threshold)
      SENSITIVE = []
      include Aws::Structure
    end

    # The details for the guardrails contextual grounding policy.
    #
    # @!attribute [rw] filters
    #   The filter details for the guardrails contextual grounding policy.
    #   @return [Array<Types::GuardrailContextualGroundingFilter>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContextualGroundingPolicy AWS API Documentation
    #
    class GuardrailContextualGroundingPolicy < Struct.new(
      :filters)
      SENSITIVE = []
      include Aws::Structure
    end

    # The policy configuration details for the guardrails contextual
    # grounding policy.
    #
    # @!attribute [rw] filters_config
    #   The filter configuration details for the guardrails contextual
    #   grounding policy.
    #   @return [Array<Types::GuardrailContextualGroundingFilterConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailContextualGroundingPolicyConfig AWS API Documentation
    #
    class GuardrailContextualGroundingPolicyConfig < Struct.new(
      :filters_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # The managed word list that was configured for the guardrail. (This is
    # a list of words that are pre-defined and managed by guardrails only.)
    #
    # @!attribute [rw] type
    #   ManagedWords$type The managed word type that was configured for the
    #   guardrail. (For now, we only offer profanity word list)
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailManagedWords AWS API Documentation
    #
    class GuardrailManagedWords < Struct.new(
      :type)
      SENSITIVE = []
      include Aws::Structure
    end

    # The managed word list to configure for the guardrail.
    #
    # @!attribute [rw] type
    #   The managed word type to configure for the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailManagedWordsConfig AWS API Documentation
    #
    class GuardrailManagedWordsConfig < Struct.new(
      :type)
      SENSITIVE = []
      include Aws::Structure
    end

    # The PII entity configured for the guardrail.
    #
    # @!attribute [rw] type
    #   The type of PII entity. For example, Social Security Number.
    #   @return [String]
    #
    # @!attribute [rw] action
    #   The configured guardrail action when PII entity is detected.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailPiiEntity AWS API Documentation
    #
    class GuardrailPiiEntity < Struct.new(
      :type,
      :action)
      SENSITIVE = []
      include Aws::Structure
    end

    # The PII entity to configure for the guardrail.
    #
    # @!attribute [rw] type
    #   Configure guardrail type when the PII entity is detected.
    #
    #   The following PIIs are used to block or mask sensitive information:
    #
    #   * **General**
    #
    #     * **ADDRESS**
    #
    #       A physical address, such as "100 Main Street, Anytown, USA" or
    #       "Suite #12, Building 123". An address can include information
    #       such as the street, building, location, city, state, country,
    #       county, zip code, precinct, and neighborhood.
    #
    #     * **AGE**
    #
    #       An individual's age, including the quantity and unit of time.
    #       For example, in the phrase "I am 40 years old," Guardrails
    #       recognizes "40 years" as an age.
    #
    #     * **NAME**
    #
    #       An individual's name. This entity type does not include titles,
    #       such as Dr., Mr., Mrs., or Miss. guardrails doesn't apply this
    #       entity type to names that are part of organizations or
    #       addresses. For example, guardrails recognizes the "John Doe
    #       Organization" as an organization, and it recognizes "Jane Doe
    #       Street" as an address.
    #
    #     * **EMAIL**
    #
    #       An email address, such as *marymajor@email.com*.
    #
    #     * **PHONE**
    #
    #       A phone number. This entity type also includes fax and pager
    #       numbers.
    #
    #     * **USERNAME**
    #
    #       A user name that identifies an account, such as a login name,
    #       screen name, nick name, or handle.
    #
    #     * **PASSWORD**
    #
    #       An alphanumeric string that is used as a password, such as
    #       "**very20special#pass**".
    #
    #     * **DRIVER\_ID**
    #
    #       The number assigned to a driver's license, which is an official
    #       document permitting an individual to operate one or more
    #       motorized vehicles on a public road. A driver's license number
    #       consists of alphanumeric characters.
    #
    #     * **LICENSE\_PLATE**
    #
    #       A license plate for a vehicle is issued by the state or country
    #       where the vehicle is registered. The format for passenger
    #       vehicles is typically five to eight digits, consisting of
    #       upper-case letters and numbers. The format varies depending on
    #       the location of the issuing state or country.
    #
    #     * **VEHICLE\_IDENTIFICATION\_NUMBER**
    #
    #       A Vehicle Identification Number (VIN) uniquely identifies a
    #       vehicle. VIN content and format are defined in the *ISO 3779*
    #       specification. Each country has specific codes and formats for
    #       VINs.
    #   * **Finance**
    #
    #     * **CREDIT\_DEBIT\_CARD\_CVV**
    #
    #       A three-digit card verification code (CVV) that is present on
    #       VISA, MasterCard, and Discover credit and debit cards. For
    #       American Express credit or debit cards, the CVV is a four-digit
    #       numeric code.
    #
    #     * **CREDIT\_DEBIT\_CARD\_EXPIRY**
    #
    #       The expiration date for a credit or debit card. This number is
    #       usually four digits long and is often formatted as *month/year*
    #       or *MM/YY*. Guardrails recognizes expiration dates such as
    #       *01/21*, *01/2021*, and *Jan 2021*.
    #
    #     * **CREDIT\_DEBIT\_CARD\_NUMBER**
    #
    #       The number for a credit or debit card. These numbers can vary
    #       from 13 to 16 digits in length. However, Amazon Comprehend also
    #       recognizes credit or debit card numbers when only the last four
    #       digits are present.
    #
    #     * **PIN**
    #
    #       A four-digit personal identification number (PIN) with which you
    #       can access your bank account.
    #
    #     * **INTERNATIONAL\_BANK\_ACCOUNT\_NUMBER**
    #
    #       An International Bank Account Number has specific formats in
    #       each country. For more information, see
    #       [www.iban.com/structure][1].
    #
    #     * **SWIFT\_CODE**
    #
    #       A SWIFT code is a standard format of Bank Identifier Code (BIC)
    #       used to specify a particular bank or branch. Banks use these
    #       codes for money transfers such as international wire transfers.
    #
    #       SWIFT codes consist of eight or 11 characters. The 11-digit
    #       codes refer to specific branches, while eight-digit codes (or
    #       11-digit codes ending in 'XXX') refer to the head or primary
    #       office.
    #   * **IT**
    #
    #     * **IP\_ADDRESS**
    #
    #       An IPv4 address, such as *198.51.100.0*.
    #
    #     * **MAC\_ADDRESS**
    #
    #       A *media access control* (MAC) address is a unique identifier
    #       assigned to a network interface controller (NIC).
    #
    #     * **URL**
    #
    #       A web address, such as *www.example.com*.
    #
    #     * **AWS\_ACCESS\_KEY**
    #
    #       A unique identifier that's associated with a secret access key;
    #       you use the access key ID and secret access key to sign
    #       programmatic Amazon Web Services requests cryptographically.
    #
    #     * **AWS\_SECRET\_KEY**
    #
    #       A unique identifier that's associated with an access key. You
    #       use the access key ID and secret access key to sign programmatic
    #       Amazon Web Services requests cryptographically.
    #   * **USA specific**
    #
    #     * **US\_BANK\_ACCOUNT\_NUMBER**
    #
    #       A US bank account number, which is typically 10 to 12 digits
    #       long.
    #
    #     * **US\_BANK\_ROUTING\_NUMBER**
    #
    #       A US bank account routing number. These are typically nine
    #       digits long,
    #
    #     * **US\_INDIVIDUAL\_TAX\_IDENTIFICATION\_NUMBER**
    #
    #       A US Individual Taxpayer Identification Number (ITIN) is a
    #       nine-digit number that starts with a "9" and contain a "7"
    #       or "8" as the fourth digit. An ITIN can be formatted with a
    #       space or a dash after the third and forth digits.
    #
    #     * **US\_PASSPORT\_NUMBER**
    #
    #       A US passport number. Passport numbers range from six to nine
    #       alphanumeric characters.
    #
    #     * **US\_SOCIAL\_SECURITY\_NUMBER**
    #
    #       A US Social Security Number (SSN) is a nine-digit number that is
    #       issued to US citizens, permanent residents, and temporary
    #       working residents.
    #   * **Canada specific**
    #
    #     * **CA\_HEALTH\_NUMBER**
    #
    #       A Canadian Health Service Number is a 10-digit unique
    #       identifier, required for individuals to access healthcare
    #       benefits.
    #
    #     * **CA\_SOCIAL\_INSURANCE\_NUMBER**
    #
    #       A Canadian Social Insurance Number (SIN) is a nine-digit unique
    #       identifier, required for individuals to access government
    #       programs and benefits.
    #
    #       The SIN is formatted as three groups of three digits, such as
    #       *123-456-789*. A SIN can be validated through a simple
    #       check-digit process called the [Luhn algorithm][2].
    #   * **UK Specific**
    #
    #     * **UK\_NATIONAL\_HEALTH\_SERVICE\_NUMBER**
    #
    #       A UK National Health Service Number is a 10-17 digit number,
    #       such as *485 777 3456*. The current system formats the 10-digit
    #       number with spaces after the third and sixth digits. The final
    #       digit is an error-detecting checksum.
    #
    #     * **UK\_NATIONAL\_INSURANCE\_NUMBER**
    #
    #       A UK National Insurance Number (NINO) provides individuals with
    #       access to National Insurance (social security) benefits. It is
    #       also used for some purposes in the UK tax system.
    #
    #       The number is nine digits long and starts with two letters,
    #       followed by six numbers and one letter. A NINO can be formatted
    #       with a space or a dash after the two letters and after the
    #       second, forth, and sixth digits.
    #
    #     * **UK\_UNIQUE\_TAXPAYER\_REFERENCE\_NUMBER**
    #
    #       A UK Unique Taxpayer Reference (UTR) is a 10-digit number that
    #       identifies a taxpayer or a business.
    #   * **Custom**
    #
    #     * **Regex filter** - You can use a regular expressions to define
    #       patterns for a guardrail to recognize and act upon such as
    #       serial number, booking ID etc..
    #
    #     ^
    #
    #
    #
    #   [1]: https://www.iban.com/structure
    #   [2]: https://www.wikipedia.org/wiki/Luhn_algorithm
    #   @return [String]
    #
    # @!attribute [rw] action
    #   Configure guardrail action when the PII entity is detected.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailPiiEntityConfig AWS API Documentation
    #
    class GuardrailPiiEntityConfig < Struct.new(
      :type,
      :action)
      SENSITIVE = []
      include Aws::Structure
    end

    # The regular expression configured for the guardrail.
    #
    # @!attribute [rw] name
    #   The name of the regular expression for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the regular expression for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] pattern
    #   The pattern of the regular expression configured for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] action
    #   The action taken when a match to the regular expression is detected.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailRegex AWS API Documentation
    #
    class GuardrailRegex < Struct.new(
      :name,
      :description,
      :pattern,
      :action)
      SENSITIVE = []
      include Aws::Structure
    end

    # The regular expression to configure for the guardrail.
    #
    # @!attribute [rw] name
    #   The name of the regular expression to configure for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the regular expression to configure for the
    #   guardrail.
    #   @return [String]
    #
    # @!attribute [rw] pattern
    #   The regular expression pattern to configure for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] action
    #   The guardrail action to configure when matching regular expression
    #   is detected.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailRegexConfig AWS API Documentation
    #
    class GuardrailRegexConfig < Struct.new(
      :name,
      :description,
      :pattern,
      :action)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about PII entities and regular expressions configured
    # for the guardrail.
    #
    # @!attribute [rw] pii_entities
    #   The list of PII entities configured for the guardrail.
    #   @return [Array<Types::GuardrailPiiEntity>]
    #
    # @!attribute [rw] regexes
    #   The list of regular expressions configured for the guardrail.
    #   @return [Array<Types::GuardrailRegex>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailSensitiveInformationPolicy AWS API Documentation
    #
    class GuardrailSensitiveInformationPolicy < Struct.new(
      :pii_entities,
      :regexes)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about PII entities and regular expressions to
    # configure for the guardrail.
    #
    # @!attribute [rw] pii_entities_config
    #   A list of PII entities to configure to the guardrail.
    #   @return [Array<Types::GuardrailPiiEntityConfig>]
    #
    # @!attribute [rw] regexes_config
    #   A list of regular expressions to configure to the guardrail.
    #   @return [Array<Types::GuardrailRegexConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailSensitiveInformationPolicyConfig AWS API Documentation
    #
    class GuardrailSensitiveInformationPolicyConfig < Struct.new(
      :pii_entities_config,
      :regexes_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about a guardrail.
    #
    # This data type is used in the following API operations:
    #
    # * [ListGuardrails response body][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListGuardrails.html#API_ListGuardrails_ResponseSyntax
    #
    # @!attribute [rw] id
    #   The unique identifier of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] arn
    #   The ARN of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   The name of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A description of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   The version of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The date and time at which the guardrail was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The date and time at which the guardrail was last updated.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailSummary AWS API Documentation
    #
    class GuardrailSummary < Struct.new(
      :id,
      :arn,
      :status,
      :name,
      :description,
      :version,
      :created_at,
      :updated_at)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # Details about topics for the guardrail to identify and deny.
    #
    # This data type is used in the following API operations:
    #
    # * [GetGuardrail response body][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax
    #
    # @!attribute [rw] name
    #   The name of the topic to deny.
    #   @return [String]
    #
    # @!attribute [rw] definition
    #   A definition of the topic to deny.
    #   @return [String]
    #
    # @!attribute [rw] examples
    #   A list of prompts, each of which is an example of a prompt that can
    #   be categorized as belonging to the topic.
    #   @return [Array<String>]
    #
    # @!attribute [rw] type
    #   Specifies to deny the topic.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailTopic AWS API Documentation
    #
    class GuardrailTopic < Struct.new(
      :name,
      :definition,
      :examples,
      :type)
      SENSITIVE = [:name, :definition, :examples]
      include Aws::Structure
    end

    # Details about topics for the guardrail to identify and deny.
    #
    # @!attribute [rw] name
    #   The name of the topic to deny.
    #   @return [String]
    #
    # @!attribute [rw] definition
    #   A definition of the topic to deny.
    #   @return [String]
    #
    # @!attribute [rw] examples
    #   A list of prompts, each of which is an example of a prompt that can
    #   be categorized as belonging to the topic.
    #   @return [Array<String>]
    #
    # @!attribute [rw] type
    #   Specifies to deny the topic.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailTopicConfig AWS API Documentation
    #
    class GuardrailTopicConfig < Struct.new(
      :name,
      :definition,
      :examples,
      :type)
      SENSITIVE = [:name, :definition, :examples]
      include Aws::Structure
    end

    # Contains details about topics that the guardrail should identify and
    # deny.
    #
    # This data type is used in the following API operations:
    #
    # * [GetGuardrail response body][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax
    #
    # @!attribute [rw] topics
    #   A list of policies related to topics that the guardrail should deny.
    #   @return [Array<Types::GuardrailTopic>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailTopicPolicy AWS API Documentation
    #
    class GuardrailTopicPolicy < Struct.new(
      :topics)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about topics that the guardrail should identify and
    # deny.
    #
    # @!attribute [rw] topics_config
    #   A list of policies related to topics that the guardrail should deny.
    #   @return [Array<Types::GuardrailTopicConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailTopicPolicyConfig AWS API Documentation
    #
    class GuardrailTopicPolicyConfig < Struct.new(
      :topics_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # A word configured for the guardrail.
    #
    # @!attribute [rw] text
    #   Text of the word configured for the guardrail to block.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailWord AWS API Documentation
    #
    class GuardrailWord < Struct.new(
      :text)
      SENSITIVE = []
      include Aws::Structure
    end

    # A word to configure for the guardrail.
    #
    # @!attribute [rw] text
    #   Text of the word configured for the guardrail to block.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailWordConfig AWS API Documentation
    #
    class GuardrailWordConfig < Struct.new(
      :text)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the word policy configured for the guardrail.
    #
    # @!attribute [rw] words
    #   A list of words configured for the guardrail.
    #   @return [Array<Types::GuardrailWord>]
    #
    # @!attribute [rw] managed_word_lists
    #   A list of managed words configured for the guardrail.
    #   @return [Array<Types::GuardrailManagedWords>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailWordPolicy AWS API Documentation
    #
    class GuardrailWordPolicy < Struct.new(
      :words,
      :managed_word_lists)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about the word policy to configured for the
    # guardrail.
    #
    # @!attribute [rw] words_config
    #   A list of words to configure for the guardrail.
    #   @return [Array<Types::GuardrailWordConfig>]
    #
    # @!attribute [rw] managed_word_lists_config
    #   A list of managed words to configure for the guardrail.
    #   @return [Array<Types::GuardrailManagedWordsConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/GuardrailWordPolicyConfig AWS API Documentation
    #
    class GuardrailWordPolicyConfig < Struct.new(
      :words_config,
      :managed_word_lists_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the custom metrics, how tasks will be rated, the flow
    # definition ARN, and your custom prompt datasets. Model evaluation jobs
    # use human workers *only* support the use of custom prompt datasets. To
    # learn more about custom prompt datasets and the required format, see
    # [Custom prompt datasets][1].
    #
    # When you create custom metrics in `HumanEvaluationCustomMetric` you
    # must specify the metric's `name`. The list of `names` specified in
    # the `HumanEvaluationCustomMetric` array, must match the `metricNames`
    # array of strings specified in `EvaluationDatasetMetricConfig`. For
    # example, if in the `HumanEvaluationCustomMetric` array your specified
    # the names `"accuracy", "toxicity", "readability"` as custom metrics
    # *then* the `metricNames` array would need to look like the following
    # `["accuracy", "toxicity", "readability"]` in
    # `EvaluationDatasetMetricConfig`.
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-prompt-datasets-custom.html
    #
    # @!attribute [rw] human_workflow_config
    #   The parameters of the human workflow.
    #   @return [Types::HumanWorkflowConfig]
    #
    # @!attribute [rw] custom_metrics
    #   A `HumanEvaluationCustomMetric` object. It contains the names the
    #   metrics, how the metrics are to be evaluated, an optional
    #   description.
    #   @return [Array<Types::HumanEvaluationCustomMetric>]
    #
    # @!attribute [rw] dataset_metric_configs
    #   Use to specify the metrics, task, and prompt dataset to be used in
    #   your model evaluation job.
    #   @return [Array<Types::EvaluationDatasetMetricConfig>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/HumanEvaluationConfig AWS API Documentation
    #
    class HumanEvaluationConfig < Struct.new(
      :human_workflow_config,
      :custom_metrics,
      :dataset_metric_configs)
      SENSITIVE = []
      include Aws::Structure
    end

    # In a model evaluation job that uses human workers you must define the
    # name of the metric, and how you want that metric rated `ratingMethod`,
    # and an optional description of the metric.
    #
    # @!attribute [rw] name
    #   The name of the metric. Your human evaluators will see this name in
    #   the evaluation UI.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   An optional description of the metric. Use this parameter to provide
    #   more details about the metric.
    #   @return [String]
    #
    # @!attribute [rw] rating_method
    #   Choose how you want your human workers to evaluation your model.
    #   Valid values for rating methods are `ThumbsUpDown`,
    #   `IndividualLikertScale`,`ComparisonLikertScale`, `ComparisonChoice`,
    #   and `ComparisonRank`
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/HumanEvaluationCustomMetric AWS API Documentation
    #
    class HumanEvaluationCustomMetric < Struct.new(
      :name,
      :description,
      :rating_method)
      SENSITIVE = [:name, :description]
      include Aws::Structure
    end

    # Contains `SageMakerFlowDefinition` object. The object is used to
    # specify the prompt dataset, task type, rating method and metric names.
    #
    # @!attribute [rw] flow_definition_arn
    #   The Amazon Resource Number (ARN) for the flow definition
    #   @return [String]
    #
    # @!attribute [rw] instructions
    #   Instructions for the flow definition
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/HumanWorkflowConfig AWS API Documentation
    #
    class HumanWorkflowConfig < Struct.new(
      :flow_definition_arn,
      :instructions)
      SENSITIVE = [:instructions]
      include Aws::Structure
    end

    # Information about the imported model.
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] model_name
    #   Name of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   Creation time of the imported model.
    #   @return [Time]
    #
    # @!attribute [rw] instruct_supported
    #   Specifies if the imported model supports converse.
    #   @return [Boolean]
    #
    # @!attribute [rw] model_architecture
    #   The architecture of the imported model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ImportedModelSummary AWS API Documentation
    #
    class ImportedModelSummary < Struct.new(
      :model_arn,
      :model_name,
      :creation_time,
      :instruct_supported,
      :model_architecture)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains information about a model.
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InferenceProfileModel AWS API Documentation
    #
    class InferenceProfileModel < Struct.new(
      :model_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains information about the model or system-defined inference
    # profile that is the source for an inference profile..
    #
    # @note InferenceProfileModelSource is a union - when making an API calls you must set exactly one of the members.
    #
    # @!attribute [rw] copy_from
    #   The ARN of the model or system-defined inference profile that is the
    #   source for the inference profile.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InferenceProfileModelSource AWS API Documentation
    #
    class InferenceProfileModelSource < Struct.new(
      :copy_from,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class CopyFrom < InferenceProfileModelSource; end
      class Unknown < InferenceProfileModelSource; end
    end

    # Contains information about an inference profile.
    #
    # @!attribute [rw] inference_profile_name
    #   The name of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   The description of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The time at which the inference profile was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The time at which the inference profile was last updated.
    #   @return [Time]
    #
    # @!attribute [rw] inference_profile_arn
    #   The Amazon Resource Name (ARN) of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] models
    #   A list of information about each model in the inference profile.
    #   @return [Array<Types::InferenceProfileModel>]
    #
    # @!attribute [rw] inference_profile_id
    #   The unique identifier of the inference profile.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the inference profile. `ACTIVE` means that the
    #   inference profile is ready to be used.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The type of the inference profile. The following types are possible:
    #
    #   * `SYSTEM_DEFINED` – The inference profile is defined by Amazon
    #     Bedrock. You can route inference requests across regions with
    #     these inference profiles.
    #
    #   * `APPLICATION` – The inference profile was created by a user. This
    #     type of inference profile can track metrics and costs when
    #     invoking the model in it. The inference profile may route requests
    #     to one or multiple regions.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InferenceProfileSummary AWS API Documentation
    #
    class InferenceProfileSummary < Struct.new(
      :inference_profile_name,
      :description,
      :created_at,
      :updated_at,
      :inference_profile_arn,
      :models,
      :inference_profile_id,
      :status,
      :type)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # An internal server error occurred. Retry your request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InternalServerException AWS API Documentation
    #
    class InternalServerException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # A storage location for invocation logs.
    #
    # @note InvocationLogSource is a union - when making an API calls you must set exactly one of the members.
    #
    # @note InvocationLogSource is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of InvocationLogSource corresponding to the set member.
    #
    # @!attribute [rw] s3_uri
    #   The URI of an invocation log in a bucket.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InvocationLogSource AWS API Documentation
    #
    class InvocationLogSource < Struct.new(
      :s3_uri,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class S3Uri < InvocationLogSource; end
      class Unknown < InvocationLogSource; end
    end

    # Settings for using invocation logs to customize a model.
    #
    # @!attribute [rw] use_prompt_response
    #   Whether to use the model's response for training, or just the
    #   prompt. The default value is `False`.
    #   @return [Boolean]
    #
    # @!attribute [rw] invocation_log_source
    #   The source of the invocation logs.
    #   @return [Types::InvocationLogSource]
    #
    # @!attribute [rw] request_metadata_filters
    #   Rules for filtering invocation logs based on request metadata.
    #   @return [Types::RequestMetadataFilters]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/InvocationLogsConfig AWS API Documentation
    #
    class InvocationLogsConfig < Struct.new(
      :use_prompt_response,
      :invocation_log_source,
      :request_metadata_filters)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains configuration details of the inference for knowledge base
    # retrieval and response generation.
    #
    # @!attribute [rw] text_inference_config
    #   Contains configuration details for text generation using a language
    #   model via the `RetrieveAndGenerate` function.
    #   @return [Types::TextInferenceConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/KbInferenceConfig AWS API Documentation
    #
    class KbInferenceConfig < Struct.new(
      :text_inference_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for retrieving information from a knowledge
    # base and generating responses.
    #
    # @note KnowledgeBaseConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note KnowledgeBaseConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of KnowledgeBaseConfig corresponding to the set member.
    #
    # @!attribute [rw] retrieve_config
    #   Contains configuration details for retrieving information from a
    #   knowledge base.
    #   @return [Types::RetrieveConfig]
    #
    # @!attribute [rw] retrieve_and_generate_config
    #   Contains configuration details for retrieving information from a
    #   knowledge base and generating responses.
    #   @return [Types::RetrieveAndGenerateConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/KnowledgeBaseConfig AWS API Documentation
    #
    class KnowledgeBaseConfig < Struct.new(
      :retrieve_config,
      :retrieve_and_generate_config,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class RetrieveConfig < KnowledgeBaseConfig; end
      class RetrieveAndGenerateConfig < KnowledgeBaseConfig; end
      class Unknown < KnowledgeBaseConfig; end
    end

    # Contains configuration details for retrieving information from a
    # knowledge base.
    #
    # @!attribute [rw] vector_search_configuration
    #   Contains configuration details for returning the results from the
    #   vector search.
    #   @return [Types::KnowledgeBaseVectorSearchConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/KnowledgeBaseRetrievalConfiguration AWS API Documentation
    #
    class KnowledgeBaseRetrievalConfiguration < Struct.new(
      :vector_search_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains configuration details for retrieving information from a
    # knowledge base and generating responses.
    #
    # @!attribute [rw] knowledge_base_id
    #   The unique identifier of the knowledge base.
    #   @return [String]
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the foundation model or [inference
    #   profile][1] used to generate responses.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html
    #   @return [String]
    #
    # @!attribute [rw] retrieval_configuration
    #   Contains configuration details for retrieving text chunks.
    #   @return [Types::KnowledgeBaseRetrievalConfiguration]
    #
    # @!attribute [rw] generation_configuration
    #   Contains configurations details for response generation based on
    #   retrieved text chunks.
    #   @return [Types::GenerationConfiguration]
    #
    # @!attribute [rw] orchestration_configuration
    #   Contains configuration details for the model to process the prompt
    #   prior to retrieval and response generation.
    #   @return [Types::OrchestrationConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/KnowledgeBaseRetrieveAndGenerateConfiguration AWS API Documentation
    #
    class KnowledgeBaseRetrieveAndGenerateConfiguration < Struct.new(
      :knowledge_base_id,
      :model_arn,
      :retrieval_configuration,
      :generation_configuration,
      :orchestration_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for returning the results from the knowledge
    # base vector search.
    #
    # @!attribute [rw] number_of_results
    #   The number of text chunks to retrieve; the number of results to
    #   return.
    #   @return [Integer]
    #
    # @!attribute [rw] override_search_type
    #   By default, Amazon Bedrock decides a search strategy for you. If
    #   you're using an Amazon OpenSearch Serverless vector store that
    #   contains a filterable text field, you can specify whether to query
    #   the knowledge base with a `HYBRID` search using both vector
    #   embeddings and raw text, or `SEMANTIC` search using only vector
    #   embeddings. For other vector store configurations, only `SEMANTIC`
    #   search is available.
    #   @return [String]
    #
    # @!attribute [rw] filter
    #   Specifies the filters to use on the metadata fields in the knowledge
    #   base data sources before returning results.
    #   @return [Types::RetrievalFilter]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/KnowledgeBaseVectorSearchConfiguration AWS API Documentation
    #
    class KnowledgeBaseVectorSearchConfiguration < Struct.new(
      :number_of_results,
      :override_search_type,
      :filter)
      SENSITIVE = [:filter]
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_before
    #   Return custom models created before the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_after
    #   Return custom models created after the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] name_contains
    #   Return custom models only if the job name contains these characters.
    #   @return [String]
    #
    # @!attribute [rw] base_model_arn_equals
    #   Return custom models only if the base model Amazon Resource Name
    #   (ARN) matches this parameter.
    #   @return [String]
    #
    # @!attribute [rw] foundation_model_arn_equals
    #   Return custom models only if the foundation model Amazon Resource
    #   Name (ARN) matches this parameter.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field to sort by in the returned list of models.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   The sort order of the results.
    #   @return [String]
    #
    # @!attribute [rw] is_owned
    #   Return custom models depending on if the current account owns them
    #   (`true`) or if they were shared with the current account (`false`).
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListCustomModelsRequest AWS API Documentation
    #
    class ListCustomModelsRequest < Struct.new(
      :creation_time_before,
      :creation_time_after,
      :name_contains,
      :base_model_arn_equals,
      :foundation_model_arn_equals,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order,
      :is_owned)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, use this token when making another
    #   request in the `nextToken` field to return the next batch of
    #   results.
    #   @return [String]
    #
    # @!attribute [rw] model_summaries
    #   Model summaries.
    #   @return [Array<Types::CustomModelSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListCustomModelsResponse AWS API Documentation
    #
    class ListCustomModelsResponse < Struct.new(
      :next_token,
      :model_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_after
    #   A filter to only list evaluation jobs created after a specified
    #   time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_before
    #   A filter to only list evaluation jobs created before a specified
    #   time.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   A filter to only list evaluation jobs that are of a certain status.
    #   @return [String]
    #
    # @!attribute [rw] application_type_equals
    #   A filter to only list evaluation jobs that are either model
    #   evaluations or knowledge base evaluations.
    #   @return [String]
    #
    # @!attribute [rw] name_contains
    #   A filter to only list evaluation jobs that contain a specified
    #   string in the job name.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   Continuation token from the previous response, for Amazon Bedrock to
    #   list the next set of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   Specifies a creation time to sort the list of evaluation jobs by
    #   when they were created.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   Specifies whether to sort the list of evaluation jobs by either
    #   ascending or descending order.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListEvaluationJobsRequest AWS API Documentation
    #
    class ListEvaluationJobsRequest < Struct.new(
      :creation_time_after,
      :creation_time_before,
      :status_equals,
      :application_type_equals,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   Continuation token from the previous response, for Amazon Bedrock to
    #   list the next set of results.
    #   @return [String]
    #
    # @!attribute [rw] job_summaries
    #   A list of summaries of the evaluation jobs.
    #   @return [Array<Types::EvaluationSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListEvaluationJobsResponse AWS API Documentation
    #
    class ListEvaluationJobsResponse < Struct.new(
      :next_token,
      :job_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] by_provider
    #   Return models belonging to the model provider that you specify.
    #   @return [String]
    #
    # @!attribute [rw] by_customization_type
    #   Return models that support the customization type that you specify.
    #   For more information, see [Custom models][1] in the [Amazon Bedrock
    #   User Guide][2].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [String]
    #
    # @!attribute [rw] by_output_modality
    #   Return models that support the output modality that you specify.
    #   @return [String]
    #
    # @!attribute [rw] by_inference_type
    #   Return models that support the inference type that you specify. For
    #   more information, see [Provisioned Throughput][1] in the [Amazon
    #   Bedrock User Guide][2].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListFoundationModelsRequest AWS API Documentation
    #
    class ListFoundationModelsRequest < Struct.new(
      :by_provider,
      :by_customization_type,
      :by_output_modality,
      :by_inference_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] model_summaries
    #   A list of Amazon Bedrock foundation models.
    #   @return [Array<Types::FoundationModelSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListFoundationModelsResponse AWS API Documentation
    #
    class ListFoundationModelsResponse < Struct.new(
      :model_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_identifier
    #   The unique identifier of the guardrail. This can be an ID or the
    #   ARN.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If there are more results than were returned in the response, the
    #   response returns a `nextToken` that you can send in another
    #   `ListGuardrails` request to see the next batch of results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListGuardrailsRequest AWS API Documentation
    #
    class ListGuardrailsRequest < Struct.new(
      :guardrail_identifier,
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] guardrails
    #   A list of objects, each of which contains details about a guardrail.
    #   @return [Array<Types::GuardrailSummary>]
    #
    # @!attribute [rw] next_token
    #   If there are more results than were returned in the response, the
    #   response returns a `nextToken` that you can send in another
    #   `ListGuardrails` request to see the next batch of results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListGuardrailsResponse AWS API Documentation
    #
    class ListGuardrailsResponse < Struct.new(
      :guardrails,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_before
    #   Return imported models that created before the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_after
    #   Return imported models that were created after the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] name_contains
    #   Return imported models only if the model name contains these
    #   characters.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field to sort by in the returned list of imported models.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   Specifies whetehr to sort the results in ascending or descending
    #   order.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListImportedModelsRequest AWS API Documentation
    #
    class ListImportedModelsRequest < Struct.new(
      :creation_time_before,
      :creation_time_after,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, use this token when making another
    #   request in the `nextToken` field to return the next batch of
    #   results.
    #   @return [String]
    #
    # @!attribute [rw] model_summaries
    #   Model summaries.
    #   @return [Array<Types::ImportedModelSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListImportedModelsResponse AWS API Documentation
    #
    class ListImportedModelsResponse < Struct.new(
      :next_token,
      :model_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] type_equals
    #   Filters for inference profiles that match the type you specify.
    #
    #   * `SYSTEM_DEFINED` – The inference profile is defined by Amazon
    #     Bedrock. You can route inference requests across regions with
    #     these inference profiles.
    #
    #   * `APPLICATION` – The inference profile was created by a user. This
    #     type of inference profile can track metrics and costs when
    #     invoking the model in it. The inference profile may route requests
    #     to one or multiple regions.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListInferenceProfilesRequest AWS API Documentation
    #
    class ListInferenceProfilesRequest < Struct.new(
      :max_results,
      :next_token,
      :type_equals)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] inference_profile_summaries
    #   A list of information about each inference profile that you can use.
    #   @return [Array<Types::InferenceProfileSummary>]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, use this token when making another
    #   request in the `nextToken` field to return the next batch of
    #   results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListInferenceProfilesResponse AWS API Documentation
    #
    class ListInferenceProfilesResponse < Struct.new(
      :inference_profile_summaries,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   The maximum number of results to return in a single call. If more
    #   results are available, the operation returns a `NextToken` value.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   The token for the next set of results. You receive this token from a
    #   previous `ListMarketplaceModelEndpoints` call.
    #   @return [String]
    #
    # @!attribute [rw] model_source_equals
    #   If specified, only endpoints for the given model source identifier
    #   are returned.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListMarketplaceModelEndpointsRequest AWS API Documentation
    #
    class ListMarketplaceModelEndpointsRequest < Struct.new(
      :max_results,
      :next_token,
      :model_source_equals)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] marketplace_model_endpoints
    #   An array of endpoint summaries.
    #   @return [Array<Types::MarketplaceModelEndpointSummary>]
    #
    # @!attribute [rw] next_token
    #   The token for the next set of results. Use this token to get the
    #   next set of results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListMarketplaceModelEndpointsResponse AWS API Documentation
    #
    class ListMarketplaceModelEndpointsResponse < Struct.new(
      :marketplace_model_endpoints,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_after
    #   Filters for model copy jobs created after the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_before
    #   Filters for model copy jobs created before the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   Filters for model copy jobs whose status matches the value that you
    #   specify.
    #   @return [String]
    #
    # @!attribute [rw] source_account_equals
    #   Filters for model copy jobs in which the account that the source
    #   model belongs to is equal to the value that you specify.
    #   @return [String]
    #
    # @!attribute [rw] source_model_arn_equals
    #   Filters for model copy jobs in which the Amazon Resource Name (ARN)
    #   of the source model to is equal to the value that you specify.
    #   @return [String]
    #
    # @!attribute [rw] target_model_name_contains
    #   Filters for model copy jobs in which the name of the copied model
    #   contains the string that you specify.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field to sort by in the returned list of model copy jobs.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   Specifies whether to sort the results in ascending or descending
    #   order.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelCopyJobsRequest AWS API Documentation
    #
    class ListModelCopyJobsRequest < Struct.new(
      :creation_time_after,
      :creation_time_before,
      :status_equals,
      :source_account_equals,
      :source_model_arn_equals,
      :target_model_name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, use this token when making another
    #   request in the `nextToken` field to return the next batch of
    #   results.
    #   @return [String]
    #
    # @!attribute [rw] model_copy_job_summaries
    #   A list of information about each model copy job.
    #   @return [Array<Types::ModelCopyJobSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelCopyJobsResponse AWS API Documentation
    #
    class ListModelCopyJobsResponse < Struct.new(
      :next_token,
      :model_copy_job_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_after
    #   Return customization jobs created after the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_before
    #   Return customization jobs created before the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   Return customization jobs with the specified status.
    #   @return [String]
    #
    # @!attribute [rw] name_contains
    #   Return customization jobs only if the job name contains these
    #   characters.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field to sort by in the returned list of jobs.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   The sort order of the results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelCustomizationJobsRequest AWS API Documentation
    #
    class ListModelCustomizationJobsRequest < Struct.new(
      :creation_time_after,
      :creation_time_before,
      :status_equals,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, use this token when making another
    #   request in the `nextToken` field to return the next batch of
    #   results.
    #   @return [String]
    #
    # @!attribute [rw] model_customization_job_summaries
    #   Job summaries.
    #   @return [Array<Types::ModelCustomizationJobSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelCustomizationJobsResponse AWS API Documentation
    #
    class ListModelCustomizationJobsResponse < Struct.new(
      :next_token,
      :model_customization_job_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_after
    #   Return import jobs that were created after the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_before
    #   Return import jobs that were created before the specified time.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   Return imported jobs with the specified status.
    #   @return [String]
    #
    # @!attribute [rw] name_contains
    #   Return imported jobs only if the job name contains these characters.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return in the response. If the
    #   total number of results is greater than this value, use the token
    #   returned in the response in the `nextToken` field when making
    #   another request to return the next batch of results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field to sort by in the returned list of imported jobs.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   Specifies whether to sort the results in ascending or descending
    #   order.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelImportJobsRequest AWS API Documentation
    #
    class ListModelImportJobsRequest < Struct.new(
      :creation_time_after,
      :creation_time_before,
      :status_equals,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If the total number of results is greater than the `maxResults`
    #   value provided in the request, enter the token returned in the
    #   `nextToken` field in the response in this field to return the next
    #   batch of results.
    #   @return [String]
    #
    # @!attribute [rw] model_import_job_summaries
    #   Import job summaries.
    #   @return [Array<Types::ModelImportJobSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelImportJobsResponse AWS API Documentation
    #
    class ListModelImportJobsResponse < Struct.new(
      :next_token,
      :model_import_job_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] submit_time_after
    #   Specify a time to filter for batch inference jobs that were
    #   submitted after the time you specify.
    #   @return [Time]
    #
    # @!attribute [rw] submit_time_before
    #   Specify a time to filter for batch inference jobs that were
    #   submitted before the time you specify.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   Specify a status to filter for batch inference jobs whose statuses
    #   match the string you specify.
    #
    #   The following statuses are possible:
    #
    #   * Submitted – This job has been submitted to a queue for validation.
    #
    #   * Validating – This job is being validated for the requirements
    #     described in [Format and upload your batch inference data][1]. The
    #     criteria include the following:
    #
    #     * Your IAM service role has access to the Amazon S3 buckets
    #       containing your files.
    #
    #     * Your files are .jsonl files and each individual record is a JSON
    #       object in the correct format. Note that validation doesn't
    #       check if the `modelInput` value matches the request body for the
    #       model.
    #
    #     * Your files fulfill the requirements for file size and number of
    #       records. For more information, see [Quotas for Amazon
    #       Bedrock][2].
    #   * Scheduled – This job has been validated and is now in a queue. The
    #     job will automatically start when it reaches its turn.
    #
    #   * Expired – This job timed out because it was scheduled but didn't
    #     begin before the set timeout duration. Submit a new job request.
    #
    #   * InProgress – This job has begun. You can start viewing the results
    #     in the output S3 location.
    #
    #   * Completed – This job has successfully completed. View the output
    #     files in the output S3 location.
    #
    #   * PartiallyCompleted – This job has partially completed. Not all of
    #     your records could be processed in time. View the output files in
    #     the output S3 location.
    #
    #   * Failed – This job has failed. Check the failure message for any
    #     further details. For further assistance, reach out to the [Amazon
    #     Web Services Support Center][3].
    #
    #   * Stopped – This job was stopped by a user.
    #
    #   * Stopping – This job is being stopped by a user.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html
    #   [3]: https://console.aws.amazon.com/support/home/
    #   @return [String]
    #
    # @!attribute [rw] name_contains
    #   Specify a string to filter for batch inference jobs whose names
    #   contain the string.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   The maximum number of results to return. If there are more results
    #   than the number that you specify, a `nextToken` value is returned.
    #   Use the `nextToken` in a request to return the next batch of
    #   results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If there were more results than the value you specified in the
    #   `maxResults` field in a previous `ListModelInvocationJobs` request,
    #   the response would have returned a `nextToken` value. To see the
    #   next batch of results, send the `nextToken` value in another
    #   request.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   An attribute by which to sort the results.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   Specifies whether to sort the results by ascending or descending
    #   order.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelInvocationJobsRequest AWS API Documentation
    #
    class ListModelInvocationJobsRequest < Struct.new(
      :submit_time_after,
      :submit_time_before,
      :status_equals,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If there are more results than can fit in the response, a
    #   `nextToken` is returned. Use the `nextToken` in a request to return
    #   the next batch of results.
    #   @return [String]
    #
    # @!attribute [rw] invocation_job_summaries
    #   A list of items, each of which contains a summary about a batch
    #   inference job.
    #   @return [Array<Types::ModelInvocationJobSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListModelInvocationJobsResponse AWS API Documentation
    #
    class ListModelInvocationJobsResponse < Struct.new(
      :next_token,
      :invocation_job_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] max_results
    #   The maximum number of prompt routers to return in one page of
    #   results.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   Specify the pagination token from a previous request to retrieve the
    #   next page of results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListPromptRoutersRequest AWS API Documentation
    #
    class ListPromptRoutersRequest < Struct.new(
      :max_results,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] prompt_router_summaries
    #   A list of prompt router summaries.
    #   @return [Array<Types::PromptRouterSummary>]
    #
    # @!attribute [rw] next_token
    #   Specify the pagination token from a previous request to retrieve the
    #   next page of results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListPromptRoutersResponse AWS API Documentation
    #
    class ListPromptRoutersResponse < Struct.new(
      :prompt_router_summaries,
      :next_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] creation_time_after
    #   A filter that returns Provisioned Throughputs created after the
    #   specified time.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time_before
    #   A filter that returns Provisioned Throughputs created before the
    #   specified time.
    #   @return [Time]
    #
    # @!attribute [rw] status_equals
    #   A filter that returns Provisioned Throughputs if their statuses
    #   matches the value that you specify.
    #   @return [String]
    #
    # @!attribute [rw] model_arn_equals
    #   A filter that returns Provisioned Throughputs whose model Amazon
    #   Resource Name (ARN) is equal to the value that you specify.
    #   @return [String]
    #
    # @!attribute [rw] name_contains
    #   A filter that returns Provisioned Throughputs if their name contains
    #   the expression that you specify.
    #   @return [String]
    #
    # @!attribute [rw] max_results
    #   THe maximum number of results to return in the response. If there
    #   are more results than the number you specified, the response returns
    #   a `nextToken` value. To see the next batch of results, send the
    #   `nextToken` value in another list request.
    #   @return [Integer]
    #
    # @!attribute [rw] next_token
    #   If there are more results than the number you specified in the
    #   `maxResults` field, the response returns a `nextToken` value. To see
    #   the next batch of results, specify the `nextToken` value in this
    #   field.
    #   @return [String]
    #
    # @!attribute [rw] sort_by
    #   The field by which to sort the returned list of Provisioned
    #   Throughputs.
    #   @return [String]
    #
    # @!attribute [rw] sort_order
    #   The sort order of the results.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListProvisionedModelThroughputsRequest AWS API Documentation
    #
    class ListProvisionedModelThroughputsRequest < Struct.new(
      :creation_time_after,
      :creation_time_before,
      :status_equals,
      :model_arn_equals,
      :name_contains,
      :max_results,
      :next_token,
      :sort_by,
      :sort_order)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] next_token
    #   If there are more results than the number you specified in the
    #   `maxResults` field, this value is returned. To see the next batch of
    #   results, include this value in the `nextToken` field in another list
    #   request.
    #   @return [String]
    #
    # @!attribute [rw] provisioned_model_summaries
    #   A list of summaries, one for each Provisioned Throughput in the
    #   response.
    #   @return [Array<Types::ProvisionedModelSummary>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListProvisionedModelThroughputsResponse AWS API Documentation
    #
    class ListProvisionedModelThroughputsResponse < Struct.new(
      :next_token,
      :provisioned_model_summaries)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the resource.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListTagsForResourceRequest AWS API Documentation
    #
    class ListTagsForResourceRequest < Struct.new(
      :resource_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] tags
    #   An array of the tags associated with this resource.
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ListTagsForResourceResponse AWS API Documentation
    #
    class ListTagsForResourceResponse < Struct.new(
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # Configuration fields for invocation logging.
    #
    # @!attribute [rw] cloud_watch_config
    #   CloudWatch logging configuration.
    #   @return [Types::CloudWatchConfig]
    #
    # @!attribute [rw] s3_config
    #   S3 configuration for storing log data.
    #   @return [Types::S3Config]
    #
    # @!attribute [rw] text_data_delivery_enabled
    #   Set to include text data in the log delivery.
    #   @return [Boolean]
    #
    # @!attribute [rw] image_data_delivery_enabled
    #   Set to include image data in the log delivery.
    #   @return [Boolean]
    #
    # @!attribute [rw] embedding_data_delivery_enabled
    #   Set to include embeddings data in the log delivery.
    #   @return [Boolean]
    #
    # @!attribute [rw] video_data_delivery_enabled
    #   Set to include video data in the log delivery.
    #   @return [Boolean]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/LoggingConfig AWS API Documentation
    #
    class LoggingConfig < Struct.new(
      :cloud_watch_config,
      :s3_config,
      :text_data_delivery_enabled,
      :image_data_delivery_enabled,
      :embedding_data_delivery_enabled,
      :video_data_delivery_enabled)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about an endpoint for a model from Amazon Bedrock
    # Marketplace.
    #
    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint.
    #   @return [String]
    #
    # @!attribute [rw] model_source_identifier
    #   The ARN of the model from Amazon Bedrock Marketplace that is
    #   deployed on this endpoint.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The overall status of the endpoint in Amazon Bedrock Marketplace
    #   (e.g., ACTIVE, INACTIVE).
    #   @return [String]
    #
    # @!attribute [rw] status_message
    #   Additional information about the overall status, if available.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The timestamp when the endpoint was registered.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The timestamp when the endpoint was last updated.
    #   @return [Time]
    #
    # @!attribute [rw] endpoint_config
    #   The configuration of the endpoint, including the number and type of
    #   instances used.
    #   @return [Types::EndpointConfig]
    #
    # @!attribute [rw] endpoint_status
    #   The current status of the endpoint (e.g., Creating, InService,
    #   Updating, Failed).
    #   @return [String]
    #
    # @!attribute [rw] endpoint_status_message
    #   Additional information about the endpoint status, if available.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/MarketplaceModelEndpoint AWS API Documentation
    #
    class MarketplaceModelEndpoint < Struct.new(
      :endpoint_arn,
      :model_source_identifier,
      :status,
      :status_message,
      :created_at,
      :updated_at,
      :endpoint_config,
      :endpoint_status,
      :endpoint_status_message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Provides a summary of an endpoint for a model from Amazon Bedrock
    # Marketplace.
    #
    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint.
    #   @return [String]
    #
    # @!attribute [rw] model_source_identifier
    #   The ARN of the model from Amazon Bedrock Marketplace that is
    #   deployed on this endpoint.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The overall status of the endpoint in Amazon Bedrock Marketplace.
    #   @return [String]
    #
    # @!attribute [rw] status_message
    #   Additional information about the overall status, if available.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   The timestamp when the endpoint was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   The timestamp when the endpoint was last updated.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/MarketplaceModelEndpointSummary AWS API Documentation
    #
    class MarketplaceModelEndpointSummary < Struct.new(
      :endpoint_arn,
      :model_source_identifier,
      :status,
      :status_message,
      :created_at,
      :updated_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains details about each model copy job.
    #
    # This data type is used in the following API operations:
    #
    # * [ListModelCopyJobs response][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListModelCopyJobs.html#API_ListModelCopyJobs_ResponseSyntax
    #
    # @!attribute [rw] job_arn
    #   The Amazon Resoource Name (ARN) of the model copy job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the model copy job.
    #   @return [String]
    #
    # @!attribute [rw] creation_time
    #   The time that the model copy job was created.
    #   @return [Time]
    #
    # @!attribute [rw] target_model_arn
    #   The Amazon Resource Name (ARN) of the copied model.
    #   @return [String]
    #
    # @!attribute [rw] target_model_name
    #   The name of the copied model.
    #   @return [String]
    #
    # @!attribute [rw] source_account_id
    #   The unique identifier of the account that the model being copied
    #   originated from.
    #   @return [String]
    #
    # @!attribute [rw] source_model_arn
    #   The Amazon Resource Name (ARN) of the original model being copied.
    #   @return [String]
    #
    # @!attribute [rw] target_model_kms_key_arn
    #   The Amazon Resource Name (ARN) of the KMS key used to encrypt the
    #   copied model.
    #   @return [String]
    #
    # @!attribute [rw] target_model_tags
    #   Tags associated with the copied model.
    #   @return [Array<Types::Tag>]
    #
    # @!attribute [rw] failure_message
    #   If a model fails to be copied, a message describing why the job
    #   failed is included here.
    #   @return [String]
    #
    # @!attribute [rw] source_model_name
    #   The name of the original model being copied.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelCopyJobSummary AWS API Documentation
    #
    class ModelCopyJobSummary < Struct.new(
      :job_arn,
      :status,
      :creation_time,
      :target_model_arn,
      :target_model_name,
      :source_account_id,
      :source_model_arn,
      :target_model_kms_key_arn,
      :target_model_tags,
      :failure_message,
      :source_model_name)
      SENSITIVE = []
      include Aws::Structure
    end

    # Information about one customization job
    #
    # @!attribute [rw] job_arn
    #   Amazon Resource Name (ARN) of the customization job.
    #   @return [String]
    #
    # @!attribute [rw] base_model_arn
    #   Amazon Resource Name (ARN) of the base model.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   Name of the customization job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   Status of the customization job.
    #   @return [String]
    #
    # @!attribute [rw] last_modified_time
    #   Time that the customization job was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time
    #   Creation time of the custom model.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   Time that the customization job ended.
    #   @return [Time]
    #
    # @!attribute [rw] custom_model_arn
    #   Amazon Resource Name (ARN) of the custom model.
    #   @return [String]
    #
    # @!attribute [rw] custom_model_name
    #   Name of the custom model.
    #   @return [String]
    #
    # @!attribute [rw] customization_type
    #   Specifies whether to carry out continued pre-training of a model or
    #   whether to fine-tune it. For more information, see [Custom
    #   models][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelCustomizationJobSummary AWS API Documentation
    #
    class ModelCustomizationJobSummary < Struct.new(
      :job_arn,
      :base_model_arn,
      :job_name,
      :status,
      :last_modified_time,
      :creation_time,
      :end_time,
      :custom_model_arn,
      :custom_model_name,
      :customization_type)
      SENSITIVE = []
      include Aws::Structure
    end

    # Data source for the imported model.
    #
    # @note ModelDataSource is a union - when making an API calls you must set exactly one of the members.
    #
    # @note ModelDataSource is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of ModelDataSource corresponding to the set member.
    #
    # @!attribute [rw] s3_data_source
    #   The Amazon S3 data source of the imported model.
    #   @return [Types::S3DataSource]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelDataSource AWS API Documentation
    #
    class ModelDataSource < Struct.new(
      :s3_data_source,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class S3DataSource < ModelDataSource; end
      class Unknown < ModelDataSource; end
    end

    # Information about the import job.
    #
    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the import job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name of the import job.
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the imported job.
    #   @return [String]
    #
    # @!attribute [rw] last_modified_time
    #   The time when the import job was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time
    #   The time import job was created.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   The time when import job ended.
    #   @return [Time]
    #
    # @!attribute [rw] imported_model_arn
    #   The Amazon resource Name (ARN) of the imported model.
    #   @return [String]
    #
    # @!attribute [rw] imported_model_name
    #   The name of the imported model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelImportJobSummary AWS API Documentation
    #
    class ModelImportJobSummary < Struct.new(
      :job_arn,
      :job_name,
      :status,
      :last_modified_time,
      :creation_time,
      :end_time,
      :imported_model_arn,
      :imported_model_name)
      SENSITIVE = []
      include Aws::Structure
    end

    # Details about the location of the input to the batch inference job.
    #
    # @note ModelInvocationJobInputDataConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note ModelInvocationJobInputDataConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of ModelInvocationJobInputDataConfig corresponding to the set member.
    #
    # @!attribute [rw] s3_input_data_config
    #   Contains the configuration of the S3 location of the input data.
    #   @return [Types::ModelInvocationJobS3InputDataConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelInvocationJobInputDataConfig AWS API Documentation
    #
    class ModelInvocationJobInputDataConfig < Struct.new(
      :s3_input_data_config,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class S3InputDataConfig < ModelInvocationJobInputDataConfig; end
      class Unknown < ModelInvocationJobInputDataConfig; end
    end

    # Contains the configuration of the S3 location of the output data.
    #
    # @note ModelInvocationJobOutputDataConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note ModelInvocationJobOutputDataConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of ModelInvocationJobOutputDataConfig corresponding to the set member.
    #
    # @!attribute [rw] s3_output_data_config
    #   Contains the configuration of the S3 location of the output data.
    #   @return [Types::ModelInvocationJobS3OutputDataConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelInvocationJobOutputDataConfig AWS API Documentation
    #
    class ModelInvocationJobOutputDataConfig < Struct.new(
      :s3_output_data_config,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class S3OutputDataConfig < ModelInvocationJobOutputDataConfig; end
      class Unknown < ModelInvocationJobOutputDataConfig; end
    end

    # Contains the configuration of the S3 location of the input data.
    #
    # @!attribute [rw] s3_input_format
    #   The format of the input data.
    #   @return [String]
    #
    # @!attribute [rw] s3_uri
    #   The S3 location of the input data.
    #   @return [String]
    #
    # @!attribute [rw] s3_bucket_owner
    #   The ID of the Amazon Web Services account that owns the S3 bucket
    #   containing the input data.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelInvocationJobS3InputDataConfig AWS API Documentation
    #
    class ModelInvocationJobS3InputDataConfig < Struct.new(
      :s3_input_format,
      :s3_uri,
      :s3_bucket_owner)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains the configuration of the S3 location of the output data.
    #
    # @!attribute [rw] s3_uri
    #   The S3 location of the output data.
    #   @return [String]
    #
    # @!attribute [rw] s3_encryption_key_id
    #   The unique identifier of the key that encrypts the S3 location of
    #   the output data.
    #   @return [String]
    #
    # @!attribute [rw] s3_bucket_owner
    #   The ID of the Amazon Web Services account that owns the S3 bucket
    #   containing the output data.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelInvocationJobS3OutputDataConfig AWS API Documentation
    #
    class ModelInvocationJobS3OutputDataConfig < Struct.new(
      :s3_uri,
      :s3_encryption_key_id,
      :s3_bucket_owner)
      SENSITIVE = []
      include Aws::Structure
    end

    # A summary of a batch inference job.
    #
    # @!attribute [rw] job_arn
    #   The Amazon Resource Name (ARN) of the batch inference job.
    #   @return [String]
    #
    # @!attribute [rw] job_name
    #   The name of the batch inference job.
    #   @return [String]
    #
    # @!attribute [rw] model_id
    #   The unique identifier of the foundation model used for model
    #   inference.
    #   @return [String]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier to ensure that the API request
    #   completes no more than one time. If this token matches a previous
    #   request, Amazon Bedrock ignores the request, but does not return an
    #   error. For more information, see [Ensuring idempotency][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html
    #   @return [String]
    #
    # @!attribute [rw] role_arn
    #   The Amazon Resource Name (ARN) of the service role with permissions
    #   to carry out and manage batch inference. You can use the console to
    #   create a default service role or follow the steps at [Create a
    #   service role for batch inference][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html
    #   @return [String]
    #
    # @!attribute [rw] status
    #   The status of the batch inference job.
    #
    #   The following statuses are possible:
    #
    #   * Submitted – This job has been submitted to a queue for validation.
    #
    #   * Validating – This job is being validated for the requirements
    #     described in [Format and upload your batch inference data][1]. The
    #     criteria include the following:
    #
    #     * Your IAM service role has access to the Amazon S3 buckets
    #       containing your files.
    #
    #     * Your files are .jsonl files and each individual record is a JSON
    #       object in the correct format. Note that validation doesn't
    #       check if the `modelInput` value matches the request body for the
    #       model.
    #
    #     * Your files fulfill the requirements for file size and number of
    #       records. For more information, see [Quotas for Amazon
    #       Bedrock][2].
    #   * Scheduled – This job has been validated and is now in a queue. The
    #     job will automatically start when it reaches its turn.
    #
    #   * Expired – This job timed out because it was scheduled but didn't
    #     begin before the set timeout duration. Submit a new job request.
    #
    #   * InProgress – This job has begun. You can start viewing the results
    #     in the output S3 location.
    #
    #   * Completed – This job has successfully completed. View the output
    #     files in the output S3 location.
    #
    #   * PartiallyCompleted – This job has partially completed. Not all of
    #     your records could be processed in time. View the output files in
    #     the output S3 location.
    #
    #   * Failed – This job has failed. Check the failure message for any
    #     further details. For further assistance, reach out to the [Amazon
    #     Web Services Support Center][3].
    #
    #   * Stopped – This job was stopped by a user.
    #
    #   * Stopping – This job is being stopped by a user.
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html
    #   [2]: https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html
    #   [3]: https://console.aws.amazon.com/support/home/
    #   @return [String]
    #
    # @!attribute [rw] message
    #   If the batch inference job failed, this field contains a message
    #   describing why the job failed.
    #   @return [String]
    #
    # @!attribute [rw] submit_time
    #   The time at which the batch inference job was submitted.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   The time at which the batch inference job was last modified.
    #   @return [Time]
    #
    # @!attribute [rw] end_time
    #   The time at which the batch inference job ended.
    #   @return [Time]
    #
    # @!attribute [rw] input_data_config
    #   Details about the location of the input to the batch inference job.
    #   @return [Types::ModelInvocationJobInputDataConfig]
    #
    # @!attribute [rw] output_data_config
    #   Details about the location of the output of the batch inference job.
    #   @return [Types::ModelInvocationJobOutputDataConfig]
    #
    # @!attribute [rw] vpc_config
    #   The configuration of the Virtual Private Cloud (VPC) for the data in
    #   the batch inference job. For more information, see [Protect batch
    #   inference jobs using a VPC][1].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc
    #   @return [Types::VpcConfig]
    #
    # @!attribute [rw] timeout_duration_in_hours
    #   The number of hours after which the batch inference job was set to
    #   time out.
    #   @return [Integer]
    #
    # @!attribute [rw] job_expiration_time
    #   The time at which the batch inference job times or timed out.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ModelInvocationJobSummary AWS API Documentation
    #
    class ModelInvocationJobSummary < Struct.new(
      :job_arn,
      :job_name,
      :model_id,
      :client_request_token,
      :role_arn,
      :status,
      :message,
      :submit_time,
      :last_modified_time,
      :end_time,
      :input_data_config,
      :output_data_config,
      :vpc_config,
      :timeout_duration_in_hours,
      :job_expiration_time)
      SENSITIVE = [:message]
      include Aws::Structure
    end

    # The configuration details for the model to process the prompt prior to
    # retrieval and response generation.
    #
    # @!attribute [rw] query_transformation_configuration
    #   Contains configuration details for transforming the prompt.
    #   @return [Types::QueryTransformationConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/OrchestrationConfiguration AWS API Documentation
    #
    class OrchestrationConfiguration < Struct.new(
      :query_transformation_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # S3 Location of the output data.
    #
    # @!attribute [rw] s3_uri
    #   The S3 URI where the output data is stored.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/OutputDataConfig AWS API Documentation
    #
    class OutputDataConfig < Struct.new(
      :s3_uri)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains performance settings for a model.
    #
    # @!attribute [rw] latency
    #   Specifies whether to use the latency-optimized or standard version
    #   of a model or inference profile.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PerformanceConfiguration AWS API Documentation
    #
    class PerformanceConfiguration < Struct.new(
      :latency)
      SENSITIVE = []
      include Aws::Structure
    end

    # Details about a prompt router.
    #
    # @!attribute [rw] prompt_router_name
    #   The router's name.
    #   @return [String]
    #
    # @!attribute [rw] routing_criteria
    #   The router's routing criteria.
    #   @return [Types::RoutingCriteria]
    #
    # @!attribute [rw] description
    #   The router's description.
    #   @return [String]
    #
    # @!attribute [rw] created_at
    #   When the router was created.
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   When the router was updated.
    #   @return [Time]
    #
    # @!attribute [rw] prompt_router_arn
    #   The router's ARN.
    #   @return [String]
    #
    # @!attribute [rw] models
    #   The router's models.
    #   @return [Array<Types::PromptRouterTargetModel>]
    #
    # @!attribute [rw] fallback_model
    #   The router's fallback model.
    #   @return [Types::PromptRouterTargetModel]
    #
    # @!attribute [rw] status
    #   The router's status.
    #   @return [String]
    #
    # @!attribute [rw] type
    #   The summary's type.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PromptRouterSummary AWS API Documentation
    #
    class PromptRouterSummary < Struct.new(
      :prompt_router_name,
      :routing_criteria,
      :description,
      :created_at,
      :updated_at,
      :prompt_router_arn,
      :models,
      :fallback_model,
      :status,
      :type)
      SENSITIVE = [:description]
      include Aws::Structure
    end

    # The target model for a prompt router.
    #
    # @!attribute [rw] model_arn
    #   The target model's ARN.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PromptRouterTargetModel AWS API Documentation
    #
    class PromptRouterTargetModel < Struct.new(
      :model_arn)
      SENSITIVE = []
      include Aws::Structure
    end

    # The template for the prompt that's sent to the model for response
    # generation.
    #
    # @!attribute [rw] text_prompt_template
    #   The template for the prompt that's sent to the model for response
    #   generation. You can include prompt placeholders, which become
    #   replaced before the prompt is sent to the model to provide
    #   instructions and context to the model. In addition, you can include
    #   XML tags to delineate meaningful sections of the prompt template.
    #
    #   For more information, see [Knowledge base prompt template][1] and
    #   [Use XML tags with Anthropic Claude models][2].
    #
    #
    #
    #   [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html
    #   [2]: https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PromptTemplate AWS API Documentation
    #
    class PromptTemplate < Struct.new(
      :text_prompt_template)
      SENSITIVE = [:text_prompt_template]
      include Aws::Structure
    end

    # A summary of information about a Provisioned Throughput.
    #
    # This data type is used in the following API operations:
    #
    # * [ListProvisionedThroughputs response][1]
    #
    # ^
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListProvisionedModelThroughputs.html#API_ListProvisionedModelThroughputs_ResponseSyntax
    #
    # @!attribute [rw] provisioned_model_name
    #   The name of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] provisioned_model_arn
    #   The Amazon Resource Name (ARN) of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] model_arn
    #   The Amazon Resource Name (ARN) of the model associated with the
    #   Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] desired_model_arn
    #   The Amazon Resource Name (ARN) of the model requested to be
    #   associated to this Provisioned Throughput. This value differs from
    #   the `modelArn` if updating hasn't completed.
    #   @return [String]
    #
    # @!attribute [rw] foundation_model_arn
    #   The Amazon Resource Name (ARN) of the base model for which the
    #   Provisioned Throughput was created, or of the base model that the
    #   custom model for which the Provisioned Throughput was created was
    #   customized.
    #   @return [String]
    #
    # @!attribute [rw] model_units
    #   The number of model units allocated to the Provisioned Throughput.
    #   @return [Integer]
    #
    # @!attribute [rw] desired_model_units
    #   The number of model units that was requested to be allocated to the
    #   Provisioned Throughput.
    #   @return [Integer]
    #
    # @!attribute [rw] status
    #   The status of the Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] commitment_duration
    #   The duration for which the Provisioned Throughput was committed.
    #   @return [String]
    #
    # @!attribute [rw] commitment_expiration_time
    #   The timestamp for when the commitment term of the Provisioned
    #   Throughput expires.
    #   @return [Time]
    #
    # @!attribute [rw] creation_time
    #   The time that the Provisioned Throughput was created.
    #   @return [Time]
    #
    # @!attribute [rw] last_modified_time
    #   The time that the Provisioned Throughput was last modified.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ProvisionedModelSummary AWS API Documentation
    #
    class ProvisionedModelSummary < Struct.new(
      :provisioned_model_name,
      :provisioned_model_arn,
      :model_arn,
      :desired_model_arn,
      :foundation_model_arn,
      :model_units,
      :desired_model_units,
      :status,
      :commitment_duration,
      :commitment_expiration_time,
      :creation_time,
      :last_modified_time)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] logging_config
    #   The logging configuration values to set.
    #   @return [Types::LoggingConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PutModelInvocationLoggingConfigurationRequest AWS API Documentation
    #
    class PutModelInvocationLoggingConfigurationRequest < Struct.new(
      :logging_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/PutModelInvocationLoggingConfigurationResponse AWS API Documentation
    #
    class PutModelInvocationLoggingConfigurationResponse < Aws::EmptyStructure; end

    # The configuration details for transforming the prompt.
    #
    # @!attribute [rw] type
    #   The type of transformation to apply to the prompt.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/QueryTransformationConfiguration AWS API Documentation
    #
    class QueryTransformationConfiguration < Struct.new(
      :type)
      SENSITIVE = []
      include Aws::Structure
    end

    # Contains configuration details for retrieval of information and
    # response generation.
    #
    # @note RAGConfig is a union - when making an API calls you must set exactly one of the members.
    #
    # @note RAGConfig is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of RAGConfig corresponding to the set member.
    #
    # @!attribute [rw] knowledge_base_config
    #   Contains configuration details for knowledge base retrieval and
    #   response generation.
    #   @return [Types::KnowledgeBaseConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RAGConfig AWS API Documentation
    #
    class RAGConfig < Struct.new(
      :knowledge_base_config,
      :unknown)
      SENSITIVE = []
      include Aws::Structure
      include Aws::Structure::Union

      class KnowledgeBaseConfig < RAGConfig; end
      class Unknown < RAGConfig; end
    end

    # @!attribute [rw] endpoint_identifier
    #   The ARN of the Amazon SageMaker endpoint you want to register with
    #   Amazon Bedrock Marketplace.
    #   @return [String]
    #
    # @!attribute [rw] model_source_identifier
    #   The ARN of the model from Amazon Bedrock Marketplace that is
    #   deployed on the endpoint.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RegisterMarketplaceModelEndpointRequest AWS API Documentation
    #
    class RegisterMarketplaceModelEndpointRequest < Struct.new(
      :endpoint_identifier,
      :model_source_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] marketplace_model_endpoint
    #   Details about the registered endpoint.
    #   @return [Types::MarketplaceModelEndpoint]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RegisterMarketplaceModelEndpointResponse AWS API Documentation
    #
    class RegisterMarketplaceModelEndpointResponse < Struct.new(
      :marketplace_model_endpoint)
      SENSITIVE = []
      include Aws::Structure
    end

    # A mapping of a metadata key to a value that it should or should not
    # equal.
    #
    # @!attribute [rw] equals
    #   Include results where the key equals the value.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] not_equals
    #   Include results where the key does not equal the value.
    #   @return [Hash<String,String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RequestMetadataBaseFilters AWS API Documentation
    #
    class RequestMetadataBaseFilters < Struct.new(
      :equals,
      :not_equals)
      SENSITIVE = [:equals, :not_equals]
      include Aws::Structure
    end

    # Rules for filtering invocation logs. A filter can be a mapping of a
    # metadata key to a value that it should or should not equal (a base
    # filter), or a list of base filters that are all applied with `AND` or
    # `OR` logical operators
    #
    # @note RequestMetadataFilters is a union - when making an API calls you must set exactly one of the members.
    #
    # @note RequestMetadataFilters is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of RequestMetadataFilters corresponding to the set member.
    #
    # @!attribute [rw] equals
    #   Include results where the key equals the value.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] not_equals
    #   Include results where the key does not equal the value.
    #   @return [Hash<String,String>]
    #
    # @!attribute [rw] and_all
    #   Include results where all of the based filters match.
    #   @return [Array<Types::RequestMetadataBaseFilters>]
    #
    # @!attribute [rw] or_all
    #   Include results where any of the base filters match.
    #   @return [Array<Types::RequestMetadataBaseFilters>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RequestMetadataFilters AWS API Documentation
    #
    class RequestMetadataFilters < Struct.new(
      :equals,
      :not_equals,
      :and_all,
      :or_all,
      :unknown)
      SENSITIVE = [:equals, :not_equals]
      include Aws::Structure
      include Aws::Structure::Union

      class Equals < RequestMetadataFilters; end
      class NotEquals < RequestMetadataFilters; end
      class AndAll < RequestMetadataFilters; end
      class OrAll < RequestMetadataFilters; end
      class Unknown < RequestMetadataFilters; end
    end

    # The specified resource Amazon Resource Name (ARN) was not found. Check
    # the Amazon Resource Name (ARN) and try your request again.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ResourceNotFoundException AWS API Documentation
    #
    class ResourceNotFoundException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the filters to use on the metadata attributes/fields in the
    # knowledge base data sources before returning results.
    #
    # @note RetrievalFilter is a union - when making an API calls you must set exactly one of the members.
    #
    # @note RetrievalFilter is a union - when returned from an API call exactly one value will be set and the returned type will be a subclass of RetrievalFilter corresponding to the set member.
    #
    # @!attribute [rw] equals
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value matches the
    #   value in this object.
    #
    #   The following example would return data sources with an animal
    #   attribute whose value is 'cat': `"equals": { "key": "animal",
    #   "value": "cat" }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] not_equals
    #   Knowledge base data sources that contain a metadata attribute whose
    #   name matches the key and whose value doesn't match the value in
    #   this object are returned.
    #
    #   The following example would return data sources that don't contain
    #   an animal attribute whose value is 'cat': `"notEquals": { "key":
    #   "animal", "value": "cat" }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] greater_than
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is greater than
    #   the value in this object.
    #
    #   The following example would return data sources with an year
    #   attribute whose value is greater than '1989': `"greaterThan": {
    #   "key": "year", "value": 1989 }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] greater_than_or_equals
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is greater than
    #   or equal to the value in this object.
    #
    #   The following example would return data sources with an year
    #   attribute whose value is greater than or equal to '1989':
    #   `"greaterThanOrEquals": { "key": "year", "value": 1989 }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] less_than
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is less than
    #   the value in this object.
    #
    #   The following example would return data sources with an year
    #   attribute whose value is less than to '1989': `"lessThan": {
    #   "key": "year", "value": 1989 }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] less_than_or_equals
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is less than or
    #   equal to the value in this object.
    #
    #   The following example would return data sources with an year
    #   attribute whose value is less than or equal to '1989':
    #   `"lessThanOrEquals": { "key": "year", "value": 1989 }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] in
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is in the list
    #   specified in the value in this object.
    #
    #   The following example would return data sources with an animal
    #   attribute that is either 'cat' or 'dog': `"in": { "key":
    #   "animal", "value": ["cat", "dog"] }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] not_in
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value isn't in the
    #   list specified in the value in this object.
    #
    #   The following example would return data sources whose animal
    #   attribute is neither 'cat' nor 'dog': `"notIn": { "key":
    #   "animal", "value": ["cat", "dog"] }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] starts_with
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value starts with the
    #   value in this object. This filter is currently only supported for
    #   Amazon OpenSearch Serverless vector stores.
    #
    #   The following example would return data sources with an animal
    #   attribute starts with 'ca' (for example, 'cat' or 'camel').
    #   `"startsWith": { "key": "animal", "value": "ca" }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] list_contains
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is a list that
    #   contains the value as one of its members.
    #
    #   The following example would return data sources with an animals
    #   attribute that is a list containing a cat member (for example,
    #   `["dog", "cat"]`): `"listContains": { "key": "animals", "value":
    #   "cat" }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] string_contains
    #   Knowledge base data sources are returned if they contain a metadata
    #   attribute whose name matches the key and whose value is one of the
    #   following:
    #
    #   A string that contains the value as a substring. The following
    #   example would return data sources with an animal attribute that
    #   contains the substring at (for example, 'cat'): `"stringContains":
    #   { "key": "animal", "value": "at" }`
    #
    #   A list with a member that contains the value as a substring. The
    #   following example would return data sources with an animals
    #   attribute that is a list containing a member that contains the
    #   substring at (for example, `["dog", "cat"]`): `"stringContains": {
    #   "key": "animals", "value": "at" }`
    #   @return [Types::FilterAttribute]
    #
    # @!attribute [rw] and_all
    #   Knowledge base data sources are returned if their metadata
    #   attributes fulfill all the filter conditions inside this list.
    #   @return [Array<Types::RetrievalFilter>]
    #
    # @!attribute [rw] or_all
    #   Knowledge base data sources are returned if their metadata
    #   attributes fulfill at least one of the filter conditions inside this
    #   list.
    #   @return [Array<Types::RetrievalFilter>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RetrievalFilter AWS API Documentation
    #
    class RetrievalFilter < Struct.new(
      :equals,
      :not_equals,
      :greater_than,
      :greater_than_or_equals,
      :less_than,
      :less_than_or_equals,
      :in,
      :not_in,
      :starts_with,
      :list_contains,
      :string_contains,
      :and_all,
      :or_all,
      :unknown)
      SENSITIVE = [:and_all, :or_all]
      include Aws::Structure
      include Aws::Structure::Union

      class Equals < RetrievalFilter; end
      class NotEquals < RetrievalFilter; end
      class GreaterThan < RetrievalFilter; end
      class GreaterThanOrEquals < RetrievalFilter; end
      class LessThan < RetrievalFilter; end
      class LessThanOrEquals < RetrievalFilter; end
      class In < RetrievalFilter; end
      class NotIn < RetrievalFilter; end
      class StartsWith < RetrievalFilter; end
      class ListContains < RetrievalFilter; end
      class StringContains < RetrievalFilter; end
      class AndAll < RetrievalFilter; end
      class OrAll < RetrievalFilter; end
      class Unknown < RetrievalFilter; end
    end

    # Contains configuration details for a knowledge base retrieval and
    # response generation.
    #
    # @!attribute [rw] type
    #   The type of resource that contains your data for retrieving
    #   information and generating responses.
    #
    #   If you choose to use `EXTERNAL_SOURCES`, then currently only Claude
    #   3 Sonnet models for knowledge bases are supported.
    #   @return [String]
    #
    # @!attribute [rw] knowledge_base_configuration
    #   Contains configuration details for the knowledge base retrieval and
    #   response generation.
    #   @return [Types::KnowledgeBaseRetrieveAndGenerateConfiguration]
    #
    # @!attribute [rw] external_sources_configuration
    #   The configuration for the external source wrapper object in the
    #   `retrieveAndGenerate` function.
    #   @return [Types::ExternalSourcesRetrieveAndGenerateConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RetrieveAndGenerateConfiguration AWS API Documentation
    #
    class RetrieveAndGenerateConfiguration < Struct.new(
      :type,
      :knowledge_base_configuration,
      :external_sources_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for retrieving information from a knowledge
    # base.
    #
    # @!attribute [rw] knowledge_base_id
    #   The unique identifier of the knowledge base.
    #   @return [String]
    #
    # @!attribute [rw] knowledge_base_retrieval_configuration
    #   Contains configuration details for knowledge base retrieval.
    #   @return [Types::KnowledgeBaseRetrievalConfiguration]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RetrieveConfig AWS API Documentation
    #
    class RetrieveConfig < Struct.new(
      :knowledge_base_id,
      :knowledge_base_retrieval_configuration)
      SENSITIVE = []
      include Aws::Structure
    end

    # Routing criteria for a prompt router.
    #
    # @!attribute [rw] response_quality_difference
    #   The criteria's response quality difference.
    #   @return [Float]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/RoutingCriteria AWS API Documentation
    #
    class RoutingCriteria < Struct.new(
      :response_quality_difference)
      SENSITIVE = []
      include Aws::Structure
    end

    # S3 configuration for storing log data.
    #
    # @!attribute [rw] bucket_name
    #   S3 bucket name.
    #   @return [String]
    #
    # @!attribute [rw] key_prefix
    #   S3 prefix.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/S3Config AWS API Documentation
    #
    class S3Config < Struct.new(
      :bucket_name,
      :key_prefix)
      SENSITIVE = []
      include Aws::Structure
    end

    # The Amazon S3 data source of the imported job.
    #
    # @!attribute [rw] s3_uri
    #   The URI of the Amazon S3 data source.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/S3DataSource AWS API Documentation
    #
    class S3DataSource < Struct.new(
      :s3_uri)
      SENSITIVE = []
      include Aws::Structure
    end

    # The unique wrapper object of the document from the S3 location.
    #
    # @!attribute [rw] uri
    #   The S3 URI location for the wrapper object of the document.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/S3ObjectDoc AWS API Documentation
    #
    class S3ObjectDoc < Struct.new(
      :uri)
      SENSITIVE = []
      include Aws::Structure
    end

    # Specifies the configuration for a Amazon SageMaker endpoint.
    #
    # @!attribute [rw] initial_instance_count
    #   The number of Amazon EC2 compute instances to deploy for initial
    #   endpoint creation.
    #   @return [Integer]
    #
    # @!attribute [rw] instance_type
    #   The Amazon EC2 compute instance type to deploy for hosting the
    #   model.
    #   @return [String]
    #
    # @!attribute [rw] execution_role
    #   The ARN of the IAM role that Amazon SageMaker can assume to access
    #   model artifacts and docker image for deployment on Amazon EC2
    #   compute instances or for batch transform jobs.
    #   @return [String]
    #
    # @!attribute [rw] kms_encryption_key
    #   The Amazon Web Services KMS key that Amazon SageMaker uses to
    #   encrypt data on the storage volume attached to the Amazon EC2
    #   compute instance that hosts the endpoint.
    #   @return [String]
    #
    # @!attribute [rw] vpc
    #   The VPC configuration for the endpoint.
    #   @return [Types::VpcConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/SageMakerEndpoint AWS API Documentation
    #
    class SageMakerEndpoint < Struct.new(
      :initial_instance_count,
      :instance_type,
      :execution_role,
      :kms_encryption_key,
      :vpc)
      SENSITIVE = []
      include Aws::Structure
    end

    # The number of requests exceeds the service quota. Resubmit your
    # request later.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ServiceQuotaExceededException AWS API Documentation
    #
    class ServiceQuotaExceededException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Returned if the service cannot complete the request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ServiceUnavailableException AWS API Documentation
    #
    class ServiceUnavailableException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] job_identifier
    #   The Amazon Resource Name (ARN) of the evaluation job you want to
    #   stop.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopEvaluationJobRequest AWS API Documentation
    #
    class StopEvaluationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = [:job_identifier]
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopEvaluationJobResponse AWS API Documentation
    #
    class StopEvaluationJobResponse < Aws::EmptyStructure; end

    # @!attribute [rw] job_identifier
    #   Job identifier of the job to stop.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopModelCustomizationJobRequest AWS API Documentation
    #
    class StopModelCustomizationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopModelCustomizationJobResponse AWS API Documentation
    #
    class StopModelCustomizationJobResponse < Aws::EmptyStructure; end

    # @!attribute [rw] job_identifier
    #   The Amazon Resource Name (ARN) of the batch inference job to stop.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopModelInvocationJobRequest AWS API Documentation
    #
    class StopModelInvocationJobRequest < Struct.new(
      :job_identifier)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/StopModelInvocationJobResponse AWS API Documentation
    #
    class StopModelInvocationJobResponse < Aws::EmptyStructure; end

    # Definition of the key/value pair for a tag.
    #
    # @!attribute [rw] key
    #   Key for the tag.
    #   @return [String]
    #
    # @!attribute [rw] value
    #   Value for the tag.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/Tag AWS API Documentation
    #
    class Tag < Struct.new(
      :key,
      :value)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the resource to tag.
    #   @return [String]
    #
    # @!attribute [rw] tags
    #   Tags to associate with the resource.
    #   @return [Array<Types::Tag>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TagResourceRequest AWS API Documentation
    #
    class TagResourceRequest < Struct.new(
      :resource_arn,
      :tags)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TagResourceResponse AWS API Documentation
    #
    class TagResourceResponse < Aws::EmptyStructure; end

    # Details about a teacher model used for model customization.
    #
    # @!attribute [rw] teacher_model_identifier
    #   The identifier of the teacher model.
    #   @return [String]
    #
    # @!attribute [rw] max_response_length_for_inference
    #   The maximum number of tokens requested when the customization job
    #   invokes the teacher model.
    #   @return [Integer]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TeacherModelConfig AWS API Documentation
    #
    class TeacherModelConfig < Struct.new(
      :teacher_model_identifier,
      :max_response_length_for_inference)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration details for text generation using a language model
    # via the `RetrieveAndGenerate` function.
    #
    # @!attribute [rw] temperature
    #   Controls the random-ness of text generated by the language model,
    #   influencing how much the model sticks to the most predictable next
    #   words versus exploring more surprising options. A lower temperature
    #   value (e.g. 0.2 or 0.3) makes model outputs more deterministic or
    #   predictable, while a higher temperature (e.g. 0.8 or 0.9) makes the
    #   outputs more creative or unpredictable.
    #   @return [Float]
    #
    # @!attribute [rw] top_p
    #   A probability distribution threshold which controls what the model
    #   considers for the set of possible next tokens. The model will only
    #   consider the top p% of the probability distribution when generating
    #   the next token.
    #   @return [Float]
    #
    # @!attribute [rw] max_tokens
    #   The maximum number of tokens to generate in the output text. Do not
    #   use the minimum of 0 or the maximum of 65536. The limit values
    #   described here are arbitrary values, for actual values consult the
    #   limits defined by your specific model.
    #   @return [Integer]
    #
    # @!attribute [rw] stop_sequences
    #   A list of sequences of characters that, if generated, will cause the
    #   model to stop generating further tokens. Do not use a minimum length
    #   of 1 or a maximum length of 1000. The limit values described here
    #   are arbitrary values, for actual values consult the limits defined
    #   by your specific model.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TextInferenceConfig AWS API Documentation
    #
    class TextInferenceConfig < Struct.new(
      :temperature,
      :top_p,
      :max_tokens,
      :stop_sequences)
      SENSITIVE = []
      include Aws::Structure
    end

    # The number of requests exceeds the limit. Resubmit your request later.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ThrottlingException AWS API Documentation
    #
    class ThrottlingException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # The request contains more tags than can be associated with a resource
    # (50 tags per resource). The maximum number of tags includes both
    # existing tags and those included in your current request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @!attribute [rw] resource_name
    #   The name of the resource with too many tags.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TooManyTagsException AWS API Documentation
    #
    class TooManyTagsException < Struct.new(
      :message,
      :resource_name)
      SENSITIVE = []
      include Aws::Structure
    end

    # S3 Location of the training data.
    #
    # @!attribute [rw] s3_uri
    #   The S3 URI where the training data is stored.
    #   @return [String]
    #
    # @!attribute [rw] invocation_logs_config
    #   Settings for using invocation logs to customize a model.
    #   @return [Types::InvocationLogsConfig]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TrainingDataConfig AWS API Documentation
    #
    class TrainingDataConfig < Struct.new(
      :s3_uri,
      :invocation_logs_config)
      SENSITIVE = []
      include Aws::Structure
    end

    # Metrics associated with the custom job.
    #
    # @!attribute [rw] training_loss
    #   Loss metric associated with the custom job.
    #   @return [Float]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/TrainingMetrics AWS API Documentation
    #
    class TrainingMetrics < Struct.new(
      :training_loss)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] resource_arn
    #   The Amazon Resource Name (ARN) of the resource to untag.
    #   @return [String]
    #
    # @!attribute [rw] tag_keys
    #   Tag keys of the tags to remove from the resource.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UntagResourceRequest AWS API Documentation
    #
    class UntagResourceRequest < Struct.new(
      :resource_arn,
      :tag_keys)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UntagResourceResponse AWS API Documentation
    #
    class UntagResourceResponse < Aws::EmptyStructure; end

    # @!attribute [rw] guardrail_identifier
    #   The unique identifier of the guardrail. This can be an ID or the
    #   ARN.
    #   @return [String]
    #
    # @!attribute [rw] name
    #   A name for the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] description
    #   A description of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] topic_policy_config
    #   The topic policy to configure for the guardrail.
    #   @return [Types::GuardrailTopicPolicyConfig]
    #
    # @!attribute [rw] content_policy_config
    #   The content policy to configure for the guardrail.
    #   @return [Types::GuardrailContentPolicyConfig]
    #
    # @!attribute [rw] word_policy_config
    #   The word policy to configure for the guardrail.
    #   @return [Types::GuardrailWordPolicyConfig]
    #
    # @!attribute [rw] sensitive_information_policy_config
    #   The sensitive information policy to configure for the guardrail.
    #   @return [Types::GuardrailSensitiveInformationPolicyConfig]
    #
    # @!attribute [rw] contextual_grounding_policy_config
    #   The contextual grounding policy configuration used to update a
    #   guardrail.
    #   @return [Types::GuardrailContextualGroundingPolicyConfig]
    #
    # @!attribute [rw] blocked_input_messaging
    #   The message to return when the guardrail blocks a prompt.
    #   @return [String]
    #
    # @!attribute [rw] blocked_outputs_messaging
    #   The message to return when the guardrail blocks a model response.
    #   @return [String]
    #
    # @!attribute [rw] kms_key_id
    #   The ARN of the KMS key with which to encrypt the guardrail.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateGuardrailRequest AWS API Documentation
    #
    class UpdateGuardrailRequest < Struct.new(
      :guardrail_identifier,
      :name,
      :description,
      :topic_policy_config,
      :content_policy_config,
      :word_policy_config,
      :sensitive_information_policy_config,
      :contextual_grounding_policy_config,
      :blocked_input_messaging,
      :blocked_outputs_messaging,
      :kms_key_id)
      SENSITIVE = [:name, :description, :blocked_input_messaging, :blocked_outputs_messaging]
      include Aws::Structure
    end

    # @!attribute [rw] guardrail_id
    #   The unique identifier of the guardrail
    #   @return [String]
    #
    # @!attribute [rw] guardrail_arn
    #   The ARN of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] version
    #   The version of the guardrail.
    #   @return [String]
    #
    # @!attribute [rw] updated_at
    #   The date and time at which the guardrail was updated.
    #   @return [Time]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateGuardrailResponse AWS API Documentation
    #
    class UpdateGuardrailResponse < Struct.new(
      :guardrail_id,
      :guardrail_arn,
      :version,
      :updated_at)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] endpoint_arn
    #   The Amazon Resource Name (ARN) of the endpoint you want to update.
    #   @return [String]
    #
    # @!attribute [rw] endpoint_config
    #   The new configuration for the endpoint, including the number and
    #   type of instances to use.
    #   @return [Types::EndpointConfig]
    #
    # @!attribute [rw] client_request_token
    #   A unique, case-sensitive identifier that you provide to ensure the
    #   idempotency of the request. This token is listed as not required
    #   because Amazon Web Services SDKs automatically generate it for you
    #   and set this parameter. If you're not using the Amazon Web Services
    #   SDK or the CLI, you must provide this token or the action will fail.
    #
    #   **A suitable default value is auto-generated.** You should normally
    #   not need to pass this option.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateMarketplaceModelEndpointRequest AWS API Documentation
    #
    class UpdateMarketplaceModelEndpointRequest < Struct.new(
      :endpoint_arn,
      :endpoint_config,
      :client_request_token)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] marketplace_model_endpoint
    #   Details about the updated endpoint.
    #   @return [Types::MarketplaceModelEndpoint]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateMarketplaceModelEndpointResponse AWS API Documentation
    #
    class UpdateMarketplaceModelEndpointResponse < Struct.new(
      :marketplace_model_endpoint)
      SENSITIVE = []
      include Aws::Structure
    end

    # @!attribute [rw] provisioned_model_id
    #   The Amazon Resource Name (ARN) or name of the Provisioned Throughput
    #   to update.
    #   @return [String]
    #
    # @!attribute [rw] desired_provisioned_model_name
    #   The new name for this Provisioned Throughput.
    #   @return [String]
    #
    # @!attribute [rw] desired_model_id
    #   The Amazon Resource Name (ARN) of the new model to associate with
    #   this Provisioned Throughput. You can't specify this field if this
    #   Provisioned Throughput is associated with a base model.
    #
    #   If this Provisioned Throughput is associated with a custom model,
    #   you can specify one of the following options:
    #
    #   * The base model from which the custom model was customized.
    #
    #   * Another custom model that was customized from the same base model
    #     as the custom model.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateProvisionedModelThroughputRequest AWS API Documentation
    #
    class UpdateProvisionedModelThroughputRequest < Struct.new(
      :provisioned_model_id,
      :desired_provisioned_model_name,
      :desired_model_id)
      SENSITIVE = []
      include Aws::Structure
    end

    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/UpdateProvisionedModelThroughputResponse AWS API Documentation
    #
    class UpdateProvisionedModelThroughputResponse < Aws::EmptyStructure; end

    # Array of up to 10 validators.
    #
    # @!attribute [rw] validators
    #   Information about the validators.
    #   @return [Array<Types::Validator>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ValidationDataConfig AWS API Documentation
    #
    class ValidationDataConfig < Struct.new(
      :validators)
      SENSITIVE = []
      include Aws::Structure
    end

    # Input validation failed. Check your request parameters and retry the
    # request.
    #
    # @!attribute [rw] message
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ValidationException AWS API Documentation
    #
    class ValidationException < Struct.new(
      :message)
      SENSITIVE = []
      include Aws::Structure
    end

    # Information about a validator.
    #
    # @!attribute [rw] s3_uri
    #   The S3 URI where the validation data is stored.
    #   @return [String]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/Validator AWS API Documentation
    #
    class Validator < Struct.new(
      :s3_uri)
      SENSITIVE = []
      include Aws::Structure
    end

    # The metric for the validator.
    #
    # @!attribute [rw] validation_loss
    #   The validation loss associated with this validator.
    #   @return [Float]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/ValidatorMetric AWS API Documentation
    #
    class ValidatorMetric < Struct.new(
      :validation_loss)
      SENSITIVE = []
      include Aws::Structure
    end

    # The configuration of a virtual private cloud (VPC). For more
    # information, see [Protect your data using Amazon Virtual Private Cloud
    # and Amazon Web Services PrivateLink][1].
    #
    #
    #
    # [1]: https://docs.aws.amazon.com/bedrock/latest/userguide/usingVPC.html
    #
    # @!attribute [rw] subnet_ids
    #   An array of IDs for each subnet in the VPC to use.
    #   @return [Array<String>]
    #
    # @!attribute [rw] security_group_ids
    #   An array of IDs for each security group in the VPC to use.
    #   @return [Array<String>]
    #
    # @see http://docs.aws.amazon.com/goto/WebAPI/bedrock-2023-04-20/VpcConfig AWS API Documentation
    #
    class VpcConfig < Struct.new(
      :subnet_ids,
      :security_group_ids)
      SENSITIVE = []
      include Aws::Structure
    end

  end
end

