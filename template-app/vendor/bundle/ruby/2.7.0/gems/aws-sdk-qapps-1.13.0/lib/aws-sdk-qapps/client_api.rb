# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE


module Aws::QApps
  # @api private
  module ClientApi

    include Seahorse::Model

    AccessDeniedException = Shapes::StructureShape.new(name: 'AccessDeniedException')
    ActionIdentifier = Shapes::StringShape.new(name: 'ActionIdentifier')
    AmazonResourceName = Shapes::StringShape.new(name: 'AmazonResourceName')
    AppArn = Shapes::StringShape.new(name: 'AppArn')
    AppDefinition = Shapes::StructureShape.new(name: 'AppDefinition')
    AppDefinitionInput = Shapes::StructureShape.new(name: 'AppDefinitionInput')
    AppRequiredCapabilities = Shapes::ListShape.new(name: 'AppRequiredCapabilities')
    AppRequiredCapability = Shapes::StringShape.new(name: 'AppRequiredCapability')
    AppStatus = Shapes::StringShape.new(name: 'AppStatus')
    AppVersion = Shapes::IntegerShape.new(name: 'AppVersion')
    AssociateLibraryItemReviewInput = Shapes::StructureShape.new(name: 'AssociateLibraryItemReviewInput')
    AssociateQAppWithUserInput = Shapes::StructureShape.new(name: 'AssociateQAppWithUserInput')
    AttributeFilter = Shapes::StructureShape.new(name: 'AttributeFilter')
    AttributeFilters = Shapes::ListShape.new(name: 'AttributeFilters')
    BatchCreateCategoryInput = Shapes::StructureShape.new(name: 'BatchCreateCategoryInput')
    BatchCreateCategoryInputCategory = Shapes::StructureShape.new(name: 'BatchCreateCategoryInputCategory')
    BatchCreateCategoryInputCategoryColorString = Shapes::StringShape.new(name: 'BatchCreateCategoryInputCategoryColorString')
    BatchCreateCategoryInputCategoryList = Shapes::ListShape.new(name: 'BatchCreateCategoryInputCategoryList')
    BatchCreateCategoryInputCategoryTitleString = Shapes::StringShape.new(name: 'BatchCreateCategoryInputCategoryTitleString')
    BatchDeleteCategoryInput = Shapes::StructureShape.new(name: 'BatchDeleteCategoryInput')
    BatchUpdateCategoryInput = Shapes::StructureShape.new(name: 'BatchUpdateCategoryInput')
    Boolean = Shapes::BooleanShape.new(name: 'Boolean')
    Card = Shapes::UnionShape.new(name: 'Card')
    CardInput = Shapes::UnionShape.new(name: 'CardInput')
    CardList = Shapes::ListShape.new(name: 'CardList')
    CardModelList = Shapes::ListShape.new(name: 'CardModelList')
    CardOutputSource = Shapes::StringShape.new(name: 'CardOutputSource')
    CardStatus = Shapes::StructureShape.new(name: 'CardStatus')
    CardStatusMap = Shapes::MapShape.new(name: 'CardStatusMap')
    CardType = Shapes::StringShape.new(name: 'CardType')
    CardValue = Shapes::StructureShape.new(name: 'CardValue')
    CardValueList = Shapes::ListShape.new(name: 'CardValueList')
    CardValueValueString = Shapes::StringShape.new(name: 'CardValueValueString')
    CategoriesList = Shapes::ListShape.new(name: 'CategoriesList')
    Category = Shapes::StructureShape.new(name: 'Category')
    CategoryIdList = Shapes::ListShape.new(name: 'CategoryIdList')
    CategoryInput = Shapes::StructureShape.new(name: 'CategoryInput')
    CategoryInputColorString = Shapes::StringShape.new(name: 'CategoryInputColorString')
    CategoryInputTitleString = Shapes::StringShape.new(name: 'CategoryInputTitleString')
    CategoryList = Shapes::ListShape.new(name: 'CategoryList')
    CategoryListInput = Shapes::ListShape.new(name: 'CategoryListInput')
    ConflictException = Shapes::StructureShape.new(name: 'ConflictException')
    ContentTooLargeException = Shapes::StructureShape.new(name: 'ContentTooLargeException')
    ConversationMessage = Shapes::StructureShape.new(name: 'ConversationMessage')
    ConversationMessageBodyString = Shapes::StringShape.new(name: 'ConversationMessageBodyString')
    CreateLibraryItemInput = Shapes::StructureShape.new(name: 'CreateLibraryItemInput')
    CreateLibraryItemOutput = Shapes::StructureShape.new(name: 'CreateLibraryItemOutput')
    CreatePresignedUrlInput = Shapes::StructureShape.new(name: 'CreatePresignedUrlInput')
    CreatePresignedUrlInputFileContentsSha256String = Shapes::StringShape.new(name: 'CreatePresignedUrlInputFileContentsSha256String')
    CreatePresignedUrlOutput = Shapes::StructureShape.new(name: 'CreatePresignedUrlOutput')
    CreateQAppInput = Shapes::StructureShape.new(name: 'CreateQAppInput')
    CreateQAppOutput = Shapes::StructureShape.new(name: 'CreateQAppOutput')
    Default = Shapes::StringShape.new(name: 'Default')
    DeleteCategoryInputList = Shapes::ListShape.new(name: 'DeleteCategoryInputList')
    DeleteLibraryItemInput = Shapes::StructureShape.new(name: 'DeleteLibraryItemInput')
    DeleteQAppInput = Shapes::StructureShape.new(name: 'DeleteQAppInput')
    DependencyList = Shapes::ListShape.new(name: 'DependencyList')
    DescribeQAppPermissionsInput = Shapes::StructureShape.new(name: 'DescribeQAppPermissionsInput')
    DescribeQAppPermissionsOutput = Shapes::StructureShape.new(name: 'DescribeQAppPermissionsOutput')
    Description = Shapes::StringShape.new(name: 'Description')
    DisassociateLibraryItemReviewInput = Shapes::StructureShape.new(name: 'DisassociateLibraryItemReviewInput')
    DisassociateQAppFromUserInput = Shapes::StructureShape.new(name: 'DisassociateQAppFromUserInput')
    Document = Shapes::DocumentShape.new(name: 'Document', document: true)
    DocumentAttribute = Shapes::StructureShape.new(name: 'DocumentAttribute')
    DocumentAttributeKey = Shapes::StringShape.new(name: 'DocumentAttributeKey')
    DocumentAttributeStringListValue = Shapes::ListShape.new(name: 'DocumentAttributeStringListValue')
    DocumentAttributeValue = Shapes::UnionShape.new(name: 'DocumentAttributeValue')
    DocumentAttributeValueStringValueString = Shapes::StringShape.new(name: 'DocumentAttributeValueStringValueString')
    DocumentScope = Shapes::StringShape.new(name: 'DocumentScope')
    ExecutionStatus = Shapes::StringShape.new(name: 'ExecutionStatus')
    ExportQAppSessionDataInput = Shapes::StructureShape.new(name: 'ExportQAppSessionDataInput')
    ExportQAppSessionDataOutput = Shapes::StructureShape.new(name: 'ExportQAppSessionDataOutput')
    FileUploadCard = Shapes::StructureShape.new(name: 'FileUploadCard')
    FileUploadCardInput = Shapes::StructureShape.new(name: 'FileUploadCardInput')
    Filename = Shapes::StringShape.new(name: 'Filename')
    FormInputCard = Shapes::StructureShape.new(name: 'FormInputCard')
    FormInputCardInput = Shapes::StructureShape.new(name: 'FormInputCardInput')
    FormInputCardMetadata = Shapes::StructureShape.new(name: 'FormInputCardMetadata')
    FormInputCardMetadataSchema = Shapes::DocumentShape.new(name: 'FormInputCardMetadataSchema', document: true)
    GetLibraryItemInput = Shapes::StructureShape.new(name: 'GetLibraryItemInput')
    GetLibraryItemOutput = Shapes::StructureShape.new(name: 'GetLibraryItemOutput')
    GetQAppInput = Shapes::StructureShape.new(name: 'GetQAppInput')
    GetQAppOutput = Shapes::StructureShape.new(name: 'GetQAppOutput')
    GetQAppSessionInput = Shapes::StructureShape.new(name: 'GetQAppSessionInput')
    GetQAppSessionMetadataInput = Shapes::StructureShape.new(name: 'GetQAppSessionMetadataInput')
    GetQAppSessionMetadataOutput = Shapes::StructureShape.new(name: 'GetQAppSessionMetadataOutput')
    GetQAppSessionOutput = Shapes::StructureShape.new(name: 'GetQAppSessionOutput')
    ImportDocumentInput = Shapes::StructureShape.new(name: 'ImportDocumentInput')
    ImportDocumentOutput = Shapes::StructureShape.new(name: 'ImportDocumentOutput')
    InitialPrompt = Shapes::StringShape.new(name: 'InitialPrompt')
    InputCardComputeMode = Shapes::StringShape.new(name: 'InputCardComputeMode')
    InstanceId = Shapes::StringShape.new(name: 'InstanceId')
    Integer = Shapes::IntegerShape.new(name: 'Integer')
    InternalServerException = Shapes::StructureShape.new(name: 'InternalServerException')
    LibraryItemList = Shapes::ListShape.new(name: 'LibraryItemList')
    LibraryItemMember = Shapes::StructureShape.new(name: 'LibraryItemMember')
    LibraryItemStatus = Shapes::StringShape.new(name: 'LibraryItemStatus')
    ListCategoriesInput = Shapes::StructureShape.new(name: 'ListCategoriesInput')
    ListCategoriesOutput = Shapes::StructureShape.new(name: 'ListCategoriesOutput')
    ListLibraryItemsInput = Shapes::StructureShape.new(name: 'ListLibraryItemsInput')
    ListLibraryItemsOutput = Shapes::StructureShape.new(name: 'ListLibraryItemsOutput')
    ListQAppSessionDataInput = Shapes::StructureShape.new(name: 'ListQAppSessionDataInput')
    ListQAppSessionDataOutput = Shapes::StructureShape.new(name: 'ListQAppSessionDataOutput')
    ListQAppsInput = Shapes::StructureShape.new(name: 'ListQAppsInput')
    ListQAppsOutput = Shapes::StructureShape.new(name: 'ListQAppsOutput')
    ListTagsForResourceRequest = Shapes::StructureShape.new(name: 'ListTagsForResourceRequest')
    ListTagsForResourceResponse = Shapes::StructureShape.new(name: 'ListTagsForResourceResponse')
    Long = Shapes::IntegerShape.new(name: 'Long')
    MemoryReferenceList = Shapes::ListShape.new(name: 'MemoryReferenceList')
    PageLimit = Shapes::IntegerShape.new(name: 'PageLimit')
    PaginationToken = Shapes::StringShape.new(name: 'PaginationToken')
    PermissionInput = Shapes::StructureShape.new(name: 'PermissionInput')
    PermissionInputActionEnum = Shapes::StringShape.new(name: 'PermissionInputActionEnum')
    PermissionInputPrincipalString = Shapes::StringShape.new(name: 'PermissionInputPrincipalString')
    PermissionOutput = Shapes::StructureShape.new(name: 'PermissionOutput')
    PermissionOutputActionEnum = Shapes::StringShape.new(name: 'PermissionOutputActionEnum')
    PermissionsOutputList = Shapes::ListShape.new(name: 'PermissionsOutputList')
    Placeholder = Shapes::StringShape.new(name: 'Placeholder')
    PlatoString = Shapes::StringShape.new(name: 'PlatoString')
    PluginId = Shapes::StringShape.new(name: 'PluginId')
    PluginType = Shapes::StringShape.new(name: 'PluginType')
    PredictAppDefinition = Shapes::StructureShape.new(name: 'PredictAppDefinition')
    PredictQAppInput = Shapes::StructureShape.new(name: 'PredictQAppInput')
    PredictQAppInputOptions = Shapes::UnionShape.new(name: 'PredictQAppInputOptions')
    PredictQAppInputOptionsConversationList = Shapes::ListShape.new(name: 'PredictQAppInputOptionsConversationList')
    PredictQAppInputOptionsProblemStatementString = Shapes::StringShape.new(name: 'PredictQAppInputOptionsProblemStatementString')
    PredictQAppOutput = Shapes::StructureShape.new(name: 'PredictQAppOutput')
    PresignedUrlFields = Shapes::MapShape.new(name: 'PresignedUrlFields')
    PrincipalOutput = Shapes::StructureShape.new(name: 'PrincipalOutput')
    PrincipalOutputEmailString = Shapes::StringShape.new(name: 'PrincipalOutputEmailString')
    PrincipalOutputUserIdString = Shapes::StringShape.new(name: 'PrincipalOutputUserIdString')
    PrincipalOutputUserTypeEnum = Shapes::StringShape.new(name: 'PrincipalOutputUserTypeEnum')
    Prompt = Shapes::StringShape.new(name: 'Prompt')
    QAppSessionData = Shapes::StructureShape.new(name: 'QAppSessionData')
    QAppSessionDataList = Shapes::ListShape.new(name: 'QAppSessionDataList')
    QAppsTimestamp = Shapes::TimestampShape.new(name: 'QAppsTimestamp', timestampFormat: "iso8601")
    QPluginCard = Shapes::StructureShape.new(name: 'QPluginCard')
    QPluginCardInput = Shapes::StructureShape.new(name: 'QPluginCardInput')
    QQueryCard = Shapes::StructureShape.new(name: 'QQueryCard')
    QQueryCardInput = Shapes::StructureShape.new(name: 'QQueryCardInput')
    ResourceNotFoundException = Shapes::StructureShape.new(name: 'ResourceNotFoundException')
    Sender = Shapes::StringShape.new(name: 'Sender')
    ServiceQuotaExceededException = Shapes::StructureShape.new(name: 'ServiceQuotaExceededException')
    SessionName = Shapes::StringShape.new(name: 'SessionName')
    SessionSharingAcceptResponses = Shapes::BooleanShape.new(name: 'SessionSharingAcceptResponses')
    SessionSharingConfiguration = Shapes::StructureShape.new(name: 'SessionSharingConfiguration')
    SessionSharingEnabled = Shapes::BooleanShape.new(name: 'SessionSharingEnabled')
    SessionSharingRevealCards = Shapes::BooleanShape.new(name: 'SessionSharingRevealCards')
    StartQAppSessionInput = Shapes::StructureShape.new(name: 'StartQAppSessionInput')
    StartQAppSessionOutput = Shapes::StructureShape.new(name: 'StartQAppSessionOutput')
    StopQAppSessionInput = Shapes::StructureShape.new(name: 'StopQAppSessionInput')
    String = Shapes::StringShape.new(name: 'String')
    Submission = Shapes::StructureShape.new(name: 'Submission')
    SubmissionList = Shapes::ListShape.new(name: 'SubmissionList')
    SubmissionMutation = Shapes::StructureShape.new(name: 'SubmissionMutation')
    SubmissionMutationKind = Shapes::StringShape.new(name: 'SubmissionMutationKind')
    TagKey = Shapes::StringShape.new(name: 'TagKey')
    TagKeys = Shapes::ListShape.new(name: 'TagKeys')
    TagMap = Shapes::MapShape.new(name: 'TagMap')
    TagResourceRequest = Shapes::StructureShape.new(name: 'TagResourceRequest')
    TagResourceResponse = Shapes::StructureShape.new(name: 'TagResourceResponse')
    TagValue = Shapes::StringShape.new(name: 'TagValue')
    Tags = Shapes::MapShape.new(name: 'Tags')
    TextInputCard = Shapes::StructureShape.new(name: 'TextInputCard')
    TextInputCardInput = Shapes::StructureShape.new(name: 'TextInputCardInput')
    ThrottlingException = Shapes::StructureShape.new(name: 'ThrottlingException')
    Timestamp = Shapes::TimestampShape.new(name: 'Timestamp')
    Title = Shapes::StringShape.new(name: 'Title')
    UUID = Shapes::StringShape.new(name: 'UUID')
    UnauthorizedException = Shapes::StructureShape.new(name: 'UnauthorizedException')
    UntagResourceRequest = Shapes::StructureShape.new(name: 'UntagResourceRequest')
    UntagResourceResponse = Shapes::StructureShape.new(name: 'UntagResourceResponse')
    UpdateLibraryItemInput = Shapes::StructureShape.new(name: 'UpdateLibraryItemInput')
    UpdateLibraryItemMetadataInput = Shapes::StructureShape.new(name: 'UpdateLibraryItemMetadataInput')
    UpdateLibraryItemOutput = Shapes::StructureShape.new(name: 'UpdateLibraryItemOutput')
    UpdateQAppInput = Shapes::StructureShape.new(name: 'UpdateQAppInput')
    UpdateQAppOutput = Shapes::StructureShape.new(name: 'UpdateQAppOutput')
    UpdateQAppPermissionsInput = Shapes::StructureShape.new(name: 'UpdateQAppPermissionsInput')
    UpdateQAppPermissionsInputGrantPermissionsList = Shapes::ListShape.new(name: 'UpdateQAppPermissionsInputGrantPermissionsList')
    UpdateQAppPermissionsInputRevokePermissionsList = Shapes::ListShape.new(name: 'UpdateQAppPermissionsInputRevokePermissionsList')
    UpdateQAppPermissionsOutput = Shapes::StructureShape.new(name: 'UpdateQAppPermissionsOutput')
    UpdateQAppSessionInput = Shapes::StructureShape.new(name: 'UpdateQAppSessionInput')
    UpdateQAppSessionMetadataInput = Shapes::StructureShape.new(name: 'UpdateQAppSessionMetadataInput')
    UpdateQAppSessionMetadataOutput = Shapes::StructureShape.new(name: 'UpdateQAppSessionMetadataOutput')
    UpdateQAppSessionOutput = Shapes::StructureShape.new(name: 'UpdateQAppSessionOutput')
    User = Shapes::StructureShape.new(name: 'User')
    UserAppItem = Shapes::StructureShape.new(name: 'UserAppItem')
    UserAppsList = Shapes::ListShape.new(name: 'UserAppsList')
    UserId = Shapes::StringShape.new(name: 'UserId')
    ValidationException = Shapes::StructureShape.new(name: 'ValidationException')

    AccessDeniedException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    AccessDeniedException.struct_class = Types::AccessDeniedException

    AppDefinition.add_member(:app_definition_version, Shapes::ShapeRef.new(shape: String, required: true, location_name: "appDefinitionVersion"))
    AppDefinition.add_member(:cards, Shapes::ShapeRef.new(shape: CardModelList, required: true, location_name: "cards"))
    AppDefinition.add_member(:can_edit, Shapes::ShapeRef.new(shape: Boolean, location_name: "canEdit"))
    AppDefinition.struct_class = Types::AppDefinition

    AppDefinitionInput.add_member(:cards, Shapes::ShapeRef.new(shape: CardList, required: true, location_name: "cards"))
    AppDefinitionInput.add_member(:initial_prompt, Shapes::ShapeRef.new(shape: InitialPrompt, location_name: "initialPrompt"))
    AppDefinitionInput.struct_class = Types::AppDefinitionInput

    AppRequiredCapabilities.member = Shapes::ShapeRef.new(shape: AppRequiredCapability)

    AssociateLibraryItemReviewInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    AssociateLibraryItemReviewInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    AssociateLibraryItemReviewInput.struct_class = Types::AssociateLibraryItemReviewInput

    AssociateQAppWithUserInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    AssociateQAppWithUserInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    AssociateQAppWithUserInput.struct_class = Types::AssociateQAppWithUserInput

    AttributeFilter.add_member(:and_all_filters, Shapes::ShapeRef.new(shape: AttributeFilters, location_name: "andAllFilters"))
    AttributeFilter.add_member(:or_all_filters, Shapes::ShapeRef.new(shape: AttributeFilters, location_name: "orAllFilters"))
    AttributeFilter.add_member(:not_filter, Shapes::ShapeRef.new(shape: AttributeFilter, location_name: "notFilter"))
    AttributeFilter.add_member(:equals_to, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "equalsTo"))
    AttributeFilter.add_member(:contains_all, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "containsAll"))
    AttributeFilter.add_member(:contains_any, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "containsAny"))
    AttributeFilter.add_member(:greater_than, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "greaterThan"))
    AttributeFilter.add_member(:greater_than_or_equals, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "greaterThanOrEquals"))
    AttributeFilter.add_member(:less_than, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "lessThan"))
    AttributeFilter.add_member(:less_than_or_equals, Shapes::ShapeRef.new(shape: DocumentAttribute, location_name: "lessThanOrEquals"))
    AttributeFilter.struct_class = Types::AttributeFilter

    AttributeFilters.member = Shapes::ShapeRef.new(shape: AttributeFilter)

    BatchCreateCategoryInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    BatchCreateCategoryInput.add_member(:categories, Shapes::ShapeRef.new(shape: BatchCreateCategoryInputCategoryList, required: true, location_name: "categories"))
    BatchCreateCategoryInput.struct_class = Types::BatchCreateCategoryInput

    BatchCreateCategoryInputCategory.add_member(:id, Shapes::ShapeRef.new(shape: UUID, location_name: "id"))
    BatchCreateCategoryInputCategory.add_member(:title, Shapes::ShapeRef.new(shape: BatchCreateCategoryInputCategoryTitleString, required: true, location_name: "title"))
    BatchCreateCategoryInputCategory.add_member(:color, Shapes::ShapeRef.new(shape: BatchCreateCategoryInputCategoryColorString, location_name: "color"))
    BatchCreateCategoryInputCategory.struct_class = Types::BatchCreateCategoryInputCategory

    BatchCreateCategoryInputCategoryList.member = Shapes::ShapeRef.new(shape: BatchCreateCategoryInputCategory)

    BatchDeleteCategoryInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    BatchDeleteCategoryInput.add_member(:categories, Shapes::ShapeRef.new(shape: DeleteCategoryInputList, required: true, location_name: "categories"))
    BatchDeleteCategoryInput.struct_class = Types::BatchDeleteCategoryInput

    BatchUpdateCategoryInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    BatchUpdateCategoryInput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryListInput, required: true, location_name: "categories"))
    BatchUpdateCategoryInput.struct_class = Types::BatchUpdateCategoryInput

    Card.add_member(:text_input, Shapes::ShapeRef.new(shape: TextInputCard, location_name: "textInput"))
    Card.add_member(:q_query, Shapes::ShapeRef.new(shape: QQueryCard, location_name: "qQuery"))
    Card.add_member(:q_plugin, Shapes::ShapeRef.new(shape: QPluginCard, location_name: "qPlugin"))
    Card.add_member(:file_upload, Shapes::ShapeRef.new(shape: FileUploadCard, location_name: "fileUpload"))
    Card.add_member(:form_input, Shapes::ShapeRef.new(shape: FormInputCard, location_name: "formInput"))
    Card.add_member(:unknown, Shapes::ShapeRef.new(shape: nil, location_name: 'unknown'))
    Card.add_member_subclass(:text_input, Types::Card::TextInput)
    Card.add_member_subclass(:q_query, Types::Card::QQuery)
    Card.add_member_subclass(:q_plugin, Types::Card::QPlugin)
    Card.add_member_subclass(:file_upload, Types::Card::FileUpload)
    Card.add_member_subclass(:form_input, Types::Card::FormInput)
    Card.add_member_subclass(:unknown, Types::Card::Unknown)
    Card.struct_class = Types::Card

    CardInput.add_member(:text_input, Shapes::ShapeRef.new(shape: TextInputCardInput, location_name: "textInput"))
    CardInput.add_member(:q_query, Shapes::ShapeRef.new(shape: QQueryCardInput, location_name: "qQuery"))
    CardInput.add_member(:q_plugin, Shapes::ShapeRef.new(shape: QPluginCardInput, location_name: "qPlugin"))
    CardInput.add_member(:file_upload, Shapes::ShapeRef.new(shape: FileUploadCardInput, location_name: "fileUpload"))
    CardInput.add_member(:form_input, Shapes::ShapeRef.new(shape: FormInputCardInput, location_name: "formInput"))
    CardInput.add_member(:unknown, Shapes::ShapeRef.new(shape: nil, location_name: 'unknown'))
    CardInput.add_member_subclass(:text_input, Types::CardInput::TextInput)
    CardInput.add_member_subclass(:q_query, Types::CardInput::QQuery)
    CardInput.add_member_subclass(:q_plugin, Types::CardInput::QPlugin)
    CardInput.add_member_subclass(:file_upload, Types::CardInput::FileUpload)
    CardInput.add_member_subclass(:form_input, Types::CardInput::FormInput)
    CardInput.add_member_subclass(:unknown, Types::CardInput::Unknown)
    CardInput.struct_class = Types::CardInput

    CardList.member = Shapes::ShapeRef.new(shape: CardInput)

    CardModelList.member = Shapes::ShapeRef.new(shape: Card)

    CardStatus.add_member(:current_state, Shapes::ShapeRef.new(shape: ExecutionStatus, required: true, location_name: "currentState"))
    CardStatus.add_member(:current_value, Shapes::ShapeRef.new(shape: String, required: true, location_name: "currentValue"))
    CardStatus.add_member(:submissions, Shapes::ShapeRef.new(shape: SubmissionList, location_name: "submissions"))
    CardStatus.struct_class = Types::CardStatus

    CardStatusMap.key = Shapes::ShapeRef.new(shape: UUID)
    CardStatusMap.value = Shapes::ShapeRef.new(shape: CardStatus)

    CardValue.add_member(:card_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "cardId"))
    CardValue.add_member(:value, Shapes::ShapeRef.new(shape: CardValueValueString, required: true, location_name: "value"))
    CardValue.add_member(:submission_mutation, Shapes::ShapeRef.new(shape: SubmissionMutation, location_name: "submissionMutation"))
    CardValue.struct_class = Types::CardValue

    CardValueList.member = Shapes::ShapeRef.new(shape: CardValue)

    CategoriesList.member = Shapes::ShapeRef.new(shape: Category)

    Category.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    Category.add_member(:title, Shapes::ShapeRef.new(shape: String, required: true, location_name: "title"))
    Category.add_member(:color, Shapes::ShapeRef.new(shape: String, location_name: "color"))
    Category.add_member(:app_count, Shapes::ShapeRef.new(shape: Integer, location_name: "appCount"))
    Category.struct_class = Types::Category

    CategoryIdList.member = Shapes::ShapeRef.new(shape: UUID)

    CategoryInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    CategoryInput.add_member(:title, Shapes::ShapeRef.new(shape: CategoryInputTitleString, required: true, location_name: "title"))
    CategoryInput.add_member(:color, Shapes::ShapeRef.new(shape: CategoryInputColorString, location_name: "color"))
    CategoryInput.struct_class = Types::CategoryInput

    CategoryList.member = Shapes::ShapeRef.new(shape: Category)

    CategoryListInput.member = Shapes::ShapeRef.new(shape: CategoryInput)

    ConflictException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ConflictException.add_member(:resource_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceId"))
    ConflictException.add_member(:resource_type, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceType"))
    ConflictException.struct_class = Types::ConflictException

    ContentTooLargeException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ContentTooLargeException.add_member(:resource_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceId"))
    ContentTooLargeException.add_member(:resource_type, Shapes::ShapeRef.new(shape: String, required: true, location_name: "resourceType"))
    ContentTooLargeException.struct_class = Types::ContentTooLargeException

    ConversationMessage.add_member(:body, Shapes::ShapeRef.new(shape: ConversationMessageBodyString, required: true, location_name: "body"))
    ConversationMessage.add_member(:type, Shapes::ShapeRef.new(shape: Sender, required: true, location_name: "type"))
    ConversationMessage.struct_class = Types::ConversationMessage

    CreateLibraryItemInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    CreateLibraryItemInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    CreateLibraryItemInput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    CreateLibraryItemInput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryIdList, required: true, location_name: "categories"))
    CreateLibraryItemInput.struct_class = Types::CreateLibraryItemInput

    CreateLibraryItemOutput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    CreateLibraryItemOutput.add_member(:status, Shapes::ShapeRef.new(shape: String, required: true, location_name: "status"))
    CreateLibraryItemOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    CreateLibraryItemOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    CreateLibraryItemOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "updatedAt"))
    CreateLibraryItemOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, location_name: "updatedBy"))
    CreateLibraryItemOutput.add_member(:rating_count, Shapes::ShapeRef.new(shape: Integer, required: true, location_name: "ratingCount"))
    CreateLibraryItemOutput.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    CreateLibraryItemOutput.struct_class = Types::CreateLibraryItemOutput

    CreatePresignedUrlInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    CreatePresignedUrlInput.add_member(:card_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "cardId"))
    CreatePresignedUrlInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    CreatePresignedUrlInput.add_member(:file_contents_sha_256, Shapes::ShapeRef.new(shape: CreatePresignedUrlInputFileContentsSha256String, required: true, location_name: "fileContentsSha256"))
    CreatePresignedUrlInput.add_member(:file_name, Shapes::ShapeRef.new(shape: Filename, required: true, location_name: "fileName"))
    CreatePresignedUrlInput.add_member(:scope, Shapes::ShapeRef.new(shape: DocumentScope, required: true, location_name: "scope"))
    CreatePresignedUrlInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, location_name: "sessionId"))
    CreatePresignedUrlInput.struct_class = Types::CreatePresignedUrlInput

    CreatePresignedUrlOutput.add_member(:file_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "fileId"))
    CreatePresignedUrlOutput.add_member(:presigned_url, Shapes::ShapeRef.new(shape: String, required: true, location_name: "presignedUrl"))
    CreatePresignedUrlOutput.add_member(:presigned_url_fields, Shapes::ShapeRef.new(shape: PresignedUrlFields, required: true, location_name: "presignedUrlFields"))
    CreatePresignedUrlOutput.add_member(:presigned_url_expiration, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "presignedUrlExpiration"))
    CreatePresignedUrlOutput.struct_class = Types::CreatePresignedUrlOutput

    CreateQAppInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    CreateQAppInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    CreateQAppInput.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    CreateQAppInput.add_member(:app_definition, Shapes::ShapeRef.new(shape: AppDefinitionInput, required: true, location_name: "appDefinition"))
    CreateQAppInput.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, location_name: "tags"))
    CreateQAppInput.struct_class = Types::CreateQAppInput

    CreateQAppOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    CreateQAppOutput.add_member(:app_arn, Shapes::ShapeRef.new(shape: AppArn, required: true, location_name: "appArn"))
    CreateQAppOutput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    CreateQAppOutput.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    CreateQAppOutput.add_member(:initial_prompt, Shapes::ShapeRef.new(shape: InitialPrompt, location_name: "initialPrompt"))
    CreateQAppOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    CreateQAppOutput.add_member(:status, Shapes::ShapeRef.new(shape: AppStatus, required: true, location_name: "status"))
    CreateQAppOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    CreateQAppOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    CreateQAppOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "updatedAt"))
    CreateQAppOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "updatedBy"))
    CreateQAppOutput.add_member(:required_capabilities, Shapes::ShapeRef.new(shape: AppRequiredCapabilities, location_name: "requiredCapabilities"))
    CreateQAppOutput.struct_class = Types::CreateQAppOutput

    DeleteCategoryInputList.member = Shapes::ShapeRef.new(shape: UUID)

    DeleteLibraryItemInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    DeleteLibraryItemInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    DeleteLibraryItemInput.struct_class = Types::DeleteLibraryItemInput

    DeleteQAppInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    DeleteQAppInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    DeleteQAppInput.struct_class = Types::DeleteQAppInput

    DependencyList.member = Shapes::ShapeRef.new(shape: String)

    DescribeQAppPermissionsInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    DescribeQAppPermissionsInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "appId"))
    DescribeQAppPermissionsInput.struct_class = Types::DescribeQAppPermissionsInput

    DescribeQAppPermissionsOutput.add_member(:resource_arn, Shapes::ShapeRef.new(shape: String, location_name: "resourceArn"))
    DescribeQAppPermissionsOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: String, location_name: "appId"))
    DescribeQAppPermissionsOutput.add_member(:permissions, Shapes::ShapeRef.new(shape: PermissionsOutputList, location_name: "permissions"))
    DescribeQAppPermissionsOutput.struct_class = Types::DescribeQAppPermissionsOutput

    DisassociateLibraryItemReviewInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    DisassociateLibraryItemReviewInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    DisassociateLibraryItemReviewInput.struct_class = Types::DisassociateLibraryItemReviewInput

    DisassociateQAppFromUserInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    DisassociateQAppFromUserInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    DisassociateQAppFromUserInput.struct_class = Types::DisassociateQAppFromUserInput

    DocumentAttribute.add_member(:name, Shapes::ShapeRef.new(shape: DocumentAttributeKey, required: true, location_name: "name"))
    DocumentAttribute.add_member(:value, Shapes::ShapeRef.new(shape: DocumentAttributeValue, required: true, location_name: "value"))
    DocumentAttribute.struct_class = Types::DocumentAttribute

    DocumentAttributeStringListValue.member = Shapes::ShapeRef.new(shape: PlatoString)

    DocumentAttributeValue.add_member(:string_value, Shapes::ShapeRef.new(shape: DocumentAttributeValueStringValueString, location_name: "stringValue"))
    DocumentAttributeValue.add_member(:string_list_value, Shapes::ShapeRef.new(shape: DocumentAttributeStringListValue, location_name: "stringListValue"))
    DocumentAttributeValue.add_member(:long_value, Shapes::ShapeRef.new(shape: Long, location_name: "longValue"))
    DocumentAttributeValue.add_member(:date_value, Shapes::ShapeRef.new(shape: Timestamp, location_name: "dateValue"))
    DocumentAttributeValue.add_member(:unknown, Shapes::ShapeRef.new(shape: nil, location_name: 'unknown'))
    DocumentAttributeValue.add_member_subclass(:string_value, Types::DocumentAttributeValue::StringValue)
    DocumentAttributeValue.add_member_subclass(:string_list_value, Types::DocumentAttributeValue::StringListValue)
    DocumentAttributeValue.add_member_subclass(:long_value, Types::DocumentAttributeValue::LongValue)
    DocumentAttributeValue.add_member_subclass(:date_value, Types::DocumentAttributeValue::DateValue)
    DocumentAttributeValue.add_member_subclass(:unknown, Types::DocumentAttributeValue::Unknown)
    DocumentAttributeValue.struct_class = Types::DocumentAttributeValue

    ExportQAppSessionDataInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ExportQAppSessionDataInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    ExportQAppSessionDataInput.struct_class = Types::ExportQAppSessionDataInput

    ExportQAppSessionDataOutput.add_member(:csv_file_link, Shapes::ShapeRef.new(shape: String, required: true, location_name: "csvFileLink"))
    ExportQAppSessionDataOutput.add_member(:expires_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "expiresAt"))
    ExportQAppSessionDataOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    ExportQAppSessionDataOutput.struct_class = Types::ExportQAppSessionDataOutput

    FileUploadCard.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    FileUploadCard.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    FileUploadCard.add_member(:dependencies, Shapes::ShapeRef.new(shape: DependencyList, required: true, location_name: "dependencies"))
    FileUploadCard.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    FileUploadCard.add_member(:filename, Shapes::ShapeRef.new(shape: String, location_name: "filename"))
    FileUploadCard.add_member(:file_id, Shapes::ShapeRef.new(shape: String, location_name: "fileId"))
    FileUploadCard.add_member(:allow_override, Shapes::ShapeRef.new(shape: Boolean, location_name: "allowOverride"))
    FileUploadCard.struct_class = Types::FileUploadCard

    FileUploadCardInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    FileUploadCardInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    FileUploadCardInput.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    FileUploadCardInput.add_member(:filename, Shapes::ShapeRef.new(shape: Filename, location_name: "filename"))
    FileUploadCardInput.add_member(:file_id, Shapes::ShapeRef.new(shape: UUID, location_name: "fileId"))
    FileUploadCardInput.add_member(:allow_override, Shapes::ShapeRef.new(shape: Boolean, location_name: "allowOverride"))
    FileUploadCardInput.struct_class = Types::FileUploadCardInput

    FormInputCard.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    FormInputCard.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    FormInputCard.add_member(:dependencies, Shapes::ShapeRef.new(shape: DependencyList, required: true, location_name: "dependencies"))
    FormInputCard.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    FormInputCard.add_member(:metadata, Shapes::ShapeRef.new(shape: FormInputCardMetadata, required: true, location_name: "metadata"))
    FormInputCard.add_member(:compute_mode, Shapes::ShapeRef.new(shape: InputCardComputeMode, location_name: "computeMode"))
    FormInputCard.struct_class = Types::FormInputCard

    FormInputCardInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    FormInputCardInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    FormInputCardInput.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    FormInputCardInput.add_member(:metadata, Shapes::ShapeRef.new(shape: FormInputCardMetadata, required: true, location_name: "metadata"))
    FormInputCardInput.add_member(:compute_mode, Shapes::ShapeRef.new(shape: InputCardComputeMode, location_name: "computeMode"))
    FormInputCardInput.struct_class = Types::FormInputCardInput

    FormInputCardMetadata.add_member(:schema, Shapes::ShapeRef.new(shape: FormInputCardMetadataSchema, required: true, location_name: "schema"))
    FormInputCardMetadata.struct_class = Types::FormInputCardMetadata

    GetLibraryItemInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    GetLibraryItemInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "libraryItemId"))
    GetLibraryItemInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, location: "querystring", location_name: "appId"))
    GetLibraryItemInput.struct_class = Types::GetLibraryItemInput

    GetLibraryItemOutput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    GetLibraryItemOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    GetLibraryItemOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    GetLibraryItemOutput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryList, required: true, location_name: "categories"))
    GetLibraryItemOutput.add_member(:status, Shapes::ShapeRef.new(shape: String, required: true, location_name: "status"))
    GetLibraryItemOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    GetLibraryItemOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    GetLibraryItemOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "updatedAt"))
    GetLibraryItemOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, location_name: "updatedBy"))
    GetLibraryItemOutput.add_member(:rating_count, Shapes::ShapeRef.new(shape: Integer, required: true, location_name: "ratingCount"))
    GetLibraryItemOutput.add_member(:is_rated_by_user, Shapes::ShapeRef.new(shape: Boolean, location_name: "isRatedByUser"))
    GetLibraryItemOutput.add_member(:user_count, Shapes::ShapeRef.new(shape: Integer, location_name: "userCount"))
    GetLibraryItemOutput.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    GetLibraryItemOutput.struct_class = Types::GetLibraryItemOutput

    GetQAppInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    GetQAppInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "appId"))
    GetQAppInput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, location: "querystring", location_name: "appVersion"))
    GetQAppInput.struct_class = Types::GetQAppInput

    GetQAppOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    GetQAppOutput.add_member(:app_arn, Shapes::ShapeRef.new(shape: AppArn, required: true, location_name: "appArn"))
    GetQAppOutput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    GetQAppOutput.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    GetQAppOutput.add_member(:initial_prompt, Shapes::ShapeRef.new(shape: InitialPrompt, location_name: "initialPrompt"))
    GetQAppOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    GetQAppOutput.add_member(:status, Shapes::ShapeRef.new(shape: AppStatus, required: true, location_name: "status"))
    GetQAppOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    GetQAppOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    GetQAppOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "updatedAt"))
    GetQAppOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "updatedBy"))
    GetQAppOutput.add_member(:required_capabilities, Shapes::ShapeRef.new(shape: AppRequiredCapabilities, location_name: "requiredCapabilities"))
    GetQAppOutput.add_member(:app_definition, Shapes::ShapeRef.new(shape: AppDefinition, required: true, location_name: "appDefinition"))
    GetQAppOutput.struct_class = Types::GetQAppOutput

    GetQAppSessionInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    GetQAppSessionInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "sessionId"))
    GetQAppSessionInput.struct_class = Types::GetQAppSessionInput

    GetQAppSessionMetadataInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    GetQAppSessionMetadataInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "sessionId"))
    GetQAppSessionMetadataInput.struct_class = Types::GetQAppSessionMetadataInput

    GetQAppSessionMetadataOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    GetQAppSessionMetadataOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    GetQAppSessionMetadataOutput.add_member(:session_name, Shapes::ShapeRef.new(shape: SessionName, location_name: "sessionName"))
    GetQAppSessionMetadataOutput.add_member(:sharing_configuration, Shapes::ShapeRef.new(shape: SessionSharingConfiguration, required: true, location_name: "sharingConfiguration"))
    GetQAppSessionMetadataOutput.add_member(:session_owner, Shapes::ShapeRef.new(shape: Boolean, location_name: "sessionOwner"))
    GetQAppSessionMetadataOutput.struct_class = Types::GetQAppSessionMetadataOutput

    GetQAppSessionOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionId"))
    GetQAppSessionOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    GetQAppSessionOutput.add_member(:session_name, Shapes::ShapeRef.new(shape: SessionName, location_name: "sessionName"))
    GetQAppSessionOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, location_name: "appVersion"))
    GetQAppSessionOutput.add_member(:latest_published_app_version, Shapes::ShapeRef.new(shape: AppVersion, location_name: "latestPublishedAppVersion"))
    GetQAppSessionOutput.add_member(:status, Shapes::ShapeRef.new(shape: ExecutionStatus, required: true, location_name: "status"))
    GetQAppSessionOutput.add_member(:card_status, Shapes::ShapeRef.new(shape: CardStatusMap, required: true, location_name: "cardStatus"))
    GetQAppSessionOutput.add_member(:user_is_host, Shapes::ShapeRef.new(shape: Boolean, location_name: "userIsHost"))
    GetQAppSessionOutput.struct_class = Types::GetQAppSessionOutput

    ImportDocumentInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ImportDocumentInput.add_member(:card_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "cardId"))
    ImportDocumentInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    ImportDocumentInput.add_member(:file_contents_base_64, Shapes::ShapeRef.new(shape: String, required: true, location_name: "fileContentsBase64"))
    ImportDocumentInput.add_member(:file_name, Shapes::ShapeRef.new(shape: Filename, required: true, location_name: "fileName"))
    ImportDocumentInput.add_member(:scope, Shapes::ShapeRef.new(shape: DocumentScope, required: true, location_name: "scope"))
    ImportDocumentInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, location_name: "sessionId"))
    ImportDocumentInput.struct_class = Types::ImportDocumentInput

    ImportDocumentOutput.add_member(:file_id, Shapes::ShapeRef.new(shape: String, location_name: "fileId"))
    ImportDocumentOutput.struct_class = Types::ImportDocumentOutput

    InternalServerException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    InternalServerException.add_member(:retry_after_seconds, Shapes::ShapeRef.new(shape: Integer, location: "header", location_name: "Retry-After"))
    InternalServerException.struct_class = Types::InternalServerException

    LibraryItemList.member = Shapes::ShapeRef.new(shape: LibraryItemMember)

    LibraryItemMember.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    LibraryItemMember.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    LibraryItemMember.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    LibraryItemMember.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryList, required: true, location_name: "categories"))
    LibraryItemMember.add_member(:status, Shapes::ShapeRef.new(shape: String, required: true, location_name: "status"))
    LibraryItemMember.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    LibraryItemMember.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    LibraryItemMember.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "updatedAt"))
    LibraryItemMember.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, location_name: "updatedBy"))
    LibraryItemMember.add_member(:rating_count, Shapes::ShapeRef.new(shape: Integer, required: true, location_name: "ratingCount"))
    LibraryItemMember.add_member(:is_rated_by_user, Shapes::ShapeRef.new(shape: Boolean, location_name: "isRatedByUser"))
    LibraryItemMember.add_member(:user_count, Shapes::ShapeRef.new(shape: Integer, location_name: "userCount"))
    LibraryItemMember.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    LibraryItemMember.struct_class = Types::LibraryItemMember

    ListCategoriesInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ListCategoriesInput.struct_class = Types::ListCategoriesInput

    ListCategoriesOutput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoriesList, location_name: "categories"))
    ListCategoriesOutput.struct_class = Types::ListCategoriesOutput

    ListLibraryItemsInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ListLibraryItemsInput.add_member(:limit, Shapes::ShapeRef.new(shape: PageLimit, location: "querystring", location_name: "limit"))
    ListLibraryItemsInput.add_member(:next_token, Shapes::ShapeRef.new(shape: PaginationToken, location: "querystring", location_name: "nextToken"))
    ListLibraryItemsInput.add_member(:category_id, Shapes::ShapeRef.new(shape: UUID, location: "querystring", location_name: "categoryId"))
    ListLibraryItemsInput.struct_class = Types::ListLibraryItemsInput

    ListLibraryItemsOutput.add_member(:library_items, Shapes::ShapeRef.new(shape: LibraryItemList, location_name: "libraryItems"))
    ListLibraryItemsOutput.add_member(:next_token, Shapes::ShapeRef.new(shape: String, location_name: "nextToken"))
    ListLibraryItemsOutput.struct_class = Types::ListLibraryItemsOutput

    ListQAppSessionDataInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ListQAppSessionDataInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location: "querystring", location_name: "sessionId"))
    ListQAppSessionDataInput.struct_class = Types::ListQAppSessionDataInput

    ListQAppSessionDataOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    ListQAppSessionDataOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    ListQAppSessionDataOutput.add_member(:session_data, Shapes::ShapeRef.new(shape: QAppSessionDataList, location_name: "sessionData"))
    ListQAppSessionDataOutput.add_member(:next_token, Shapes::ShapeRef.new(shape: String, location_name: "nextToken"))
    ListQAppSessionDataOutput.struct_class = Types::ListQAppSessionDataOutput

    ListQAppsInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    ListQAppsInput.add_member(:limit, Shapes::ShapeRef.new(shape: PageLimit, location: "querystring", location_name: "limit"))
    ListQAppsInput.add_member(:next_token, Shapes::ShapeRef.new(shape: PaginationToken, location: "querystring", location_name: "nextToken"))
    ListQAppsInput.struct_class = Types::ListQAppsInput

    ListQAppsOutput.add_member(:apps, Shapes::ShapeRef.new(shape: UserAppsList, required: true, location_name: "apps"))
    ListQAppsOutput.add_member(:next_token, Shapes::ShapeRef.new(shape: String, location_name: "nextToken"))
    ListQAppsOutput.struct_class = Types::ListQAppsOutput

    ListTagsForResourceRequest.add_member(:resource_arn, Shapes::ShapeRef.new(shape: AmazonResourceName, required: true, location: "uri", location_name: "resourceARN"))
    ListTagsForResourceRequest.struct_class = Types::ListTagsForResourceRequest

    ListTagsForResourceResponse.add_member(:tags, Shapes::ShapeRef.new(shape: Tags, location_name: "tags"))
    ListTagsForResourceResponse.struct_class = Types::ListTagsForResourceResponse

    MemoryReferenceList.member = Shapes::ShapeRef.new(shape: String)

    PermissionInput.add_member(:action, Shapes::ShapeRef.new(shape: PermissionInputActionEnum, required: true, location_name: "action"))
    PermissionInput.add_member(:principal, Shapes::ShapeRef.new(shape: PermissionInputPrincipalString, required: true, location_name: "principal"))
    PermissionInput.struct_class = Types::PermissionInput

    PermissionOutput.add_member(:action, Shapes::ShapeRef.new(shape: PermissionOutputActionEnum, required: true, location_name: "action"))
    PermissionOutput.add_member(:principal, Shapes::ShapeRef.new(shape: PrincipalOutput, required: true, location_name: "principal"))
    PermissionOutput.struct_class = Types::PermissionOutput

    PermissionsOutputList.member = Shapes::ShapeRef.new(shape: PermissionOutput)

    PredictAppDefinition.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    PredictAppDefinition.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    PredictAppDefinition.add_member(:app_definition, Shapes::ShapeRef.new(shape: AppDefinitionInput, required: true, location_name: "appDefinition"))
    PredictAppDefinition.struct_class = Types::PredictAppDefinition

    PredictQAppInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    PredictQAppInput.add_member(:options, Shapes::ShapeRef.new(shape: PredictQAppInputOptions, location_name: "options"))
    PredictQAppInput.struct_class = Types::PredictQAppInput

    PredictQAppInputOptions.add_member(:conversation, Shapes::ShapeRef.new(shape: PredictQAppInputOptionsConversationList, location_name: "conversation"))
    PredictQAppInputOptions.add_member(:problem_statement, Shapes::ShapeRef.new(shape: PredictQAppInputOptionsProblemStatementString, location_name: "problemStatement"))
    PredictQAppInputOptions.add_member(:unknown, Shapes::ShapeRef.new(shape: nil, location_name: 'unknown'))
    PredictQAppInputOptions.add_member_subclass(:conversation, Types::PredictQAppInputOptions::Conversation)
    PredictQAppInputOptions.add_member_subclass(:problem_statement, Types::PredictQAppInputOptions::ProblemStatement)
    PredictQAppInputOptions.add_member_subclass(:unknown, Types::PredictQAppInputOptions::Unknown)
    PredictQAppInputOptions.struct_class = Types::PredictQAppInputOptions

    PredictQAppInputOptionsConversationList.member = Shapes::ShapeRef.new(shape: ConversationMessage)

    PredictQAppOutput.add_member(:app, Shapes::ShapeRef.new(shape: PredictAppDefinition, required: true, location_name: "app"))
    PredictQAppOutput.add_member(:problem_statement, Shapes::ShapeRef.new(shape: String, required: true, location_name: "problemStatement"))
    PredictQAppOutput.struct_class = Types::PredictQAppOutput

    PresignedUrlFields.key = Shapes::ShapeRef.new(shape: String)
    PresignedUrlFields.value = Shapes::ShapeRef.new(shape: String)

    PrincipalOutput.add_member(:user_id, Shapes::ShapeRef.new(shape: PrincipalOutputUserIdString, location_name: "userId"))
    PrincipalOutput.add_member(:user_type, Shapes::ShapeRef.new(shape: PrincipalOutputUserTypeEnum, location_name: "userType"))
    PrincipalOutput.add_member(:email, Shapes::ShapeRef.new(shape: PrincipalOutputEmailString, location_name: "email"))
    PrincipalOutput.struct_class = Types::PrincipalOutput

    QAppSessionData.add_member(:card_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "cardId"))
    QAppSessionData.add_member(:value, Shapes::ShapeRef.new(shape: Document, location_name: "value"))
    QAppSessionData.add_member(:user, Shapes::ShapeRef.new(shape: User, required: true, location_name: "user"))
    QAppSessionData.add_member(:submission_id, Shapes::ShapeRef.new(shape: UUID, location_name: "submissionId"))
    QAppSessionData.add_member(:timestamp, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "timestamp"))
    QAppSessionData.struct_class = Types::QAppSessionData

    QAppSessionDataList.member = Shapes::ShapeRef.new(shape: QAppSessionData)

    QPluginCard.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    QPluginCard.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    QPluginCard.add_member(:dependencies, Shapes::ShapeRef.new(shape: DependencyList, required: true, location_name: "dependencies"))
    QPluginCard.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    QPluginCard.add_member(:prompt, Shapes::ShapeRef.new(shape: Prompt, required: true, location_name: "prompt"))
    QPluginCard.add_member(:plugin_type, Shapes::ShapeRef.new(shape: PluginType, required: true, location_name: "pluginType"))
    QPluginCard.add_member(:plugin_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "pluginId"))
    QPluginCard.add_member(:action_identifier, Shapes::ShapeRef.new(shape: ActionIdentifier, location_name: "actionIdentifier"))
    QPluginCard.struct_class = Types::QPluginCard

    QPluginCardInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    QPluginCardInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    QPluginCardInput.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    QPluginCardInput.add_member(:prompt, Shapes::ShapeRef.new(shape: Prompt, required: true, location_name: "prompt"))
    QPluginCardInput.add_member(:plugin_id, Shapes::ShapeRef.new(shape: PluginId, required: true, location_name: "pluginId"))
    QPluginCardInput.add_member(:action_identifier, Shapes::ShapeRef.new(shape: ActionIdentifier, location_name: "actionIdentifier"))
    QPluginCardInput.struct_class = Types::QPluginCardInput

    QQueryCard.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    QQueryCard.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    QQueryCard.add_member(:dependencies, Shapes::ShapeRef.new(shape: DependencyList, required: true, location_name: "dependencies"))
    QQueryCard.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    QQueryCard.add_member(:prompt, Shapes::ShapeRef.new(shape: Prompt, required: true, location_name: "prompt"))
    QQueryCard.add_member(:output_source, Shapes::ShapeRef.new(shape: CardOutputSource, required: true, location_name: "outputSource"))
    QQueryCard.add_member(:attribute_filter, Shapes::ShapeRef.new(shape: AttributeFilter, location_name: "attributeFilter"))
    QQueryCard.add_member(:memory_references, Shapes::ShapeRef.new(shape: MemoryReferenceList, location_name: "memoryReferences"))
    QQueryCard.struct_class = Types::QQueryCard

    QQueryCardInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    QQueryCardInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    QQueryCardInput.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    QQueryCardInput.add_member(:prompt, Shapes::ShapeRef.new(shape: Prompt, required: true, location_name: "prompt"))
    QQueryCardInput.add_member(:output_source, Shapes::ShapeRef.new(shape: CardOutputSource, location_name: "outputSource"))
    QQueryCardInput.add_member(:attribute_filter, Shapes::ShapeRef.new(shape: AttributeFilter, location_name: "attributeFilter"))
    QQueryCardInput.struct_class = Types::QQueryCardInput

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

    SessionSharingConfiguration.add_member(:enabled, Shapes::ShapeRef.new(shape: SessionSharingEnabled, required: true, location_name: "enabled"))
    SessionSharingConfiguration.add_member(:accept_responses, Shapes::ShapeRef.new(shape: SessionSharingAcceptResponses, location_name: "acceptResponses"))
    SessionSharingConfiguration.add_member(:reveal_cards, Shapes::ShapeRef.new(shape: SessionSharingRevealCards, location_name: "revealCards"))
    SessionSharingConfiguration.struct_class = Types::SessionSharingConfiguration

    StartQAppSessionInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    StartQAppSessionInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    StartQAppSessionInput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    StartQAppSessionInput.add_member(:initial_values, Shapes::ShapeRef.new(shape: CardValueList, location_name: "initialValues"))
    StartQAppSessionInput.add_member(:session_id, Shapes::ShapeRef.new(shape: String, location_name: "sessionId"))
    StartQAppSessionInput.add_member(:tags, Shapes::ShapeRef.new(shape: TagMap, location_name: "tags"))
    StartQAppSessionInput.struct_class = Types::StartQAppSessionInput

    StartQAppSessionOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionId"))
    StartQAppSessionOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    StartQAppSessionOutput.struct_class = Types::StartQAppSessionOutput

    StopQAppSessionInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    StopQAppSessionInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    StopQAppSessionInput.struct_class = Types::StopQAppSessionInput

    Submission.add_member(:value, Shapes::ShapeRef.new(shape: Document, location_name: "value"))
    Submission.add_member(:submission_id, Shapes::ShapeRef.new(shape: UUID, location_name: "submissionId"))
    Submission.add_member(:timestamp, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "timestamp"))
    Submission.struct_class = Types::Submission

    SubmissionList.member = Shapes::ShapeRef.new(shape: Submission)

    SubmissionMutation.add_member(:submission_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "submissionId"))
    SubmissionMutation.add_member(:mutation_type, Shapes::ShapeRef.new(shape: SubmissionMutationKind, required: true, location_name: "mutationType"))
    SubmissionMutation.struct_class = Types::SubmissionMutation

    TagKeys.member = Shapes::ShapeRef.new(shape: TagKey)

    TagMap.key = Shapes::ShapeRef.new(shape: String)
    TagMap.value = Shapes::ShapeRef.new(shape: String)

    TagResourceRequest.add_member(:resource_arn, Shapes::ShapeRef.new(shape: AmazonResourceName, required: true, location: "uri", location_name: "resourceARN"))
    TagResourceRequest.add_member(:tags, Shapes::ShapeRef.new(shape: Tags, required: true, location_name: "tags"))
    TagResourceRequest.struct_class = Types::TagResourceRequest

    TagResourceResponse.struct_class = Types::TagResourceResponse

    Tags.key = Shapes::ShapeRef.new(shape: TagKey)
    Tags.value = Shapes::ShapeRef.new(shape: TagValue)

    TextInputCard.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    TextInputCard.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    TextInputCard.add_member(:dependencies, Shapes::ShapeRef.new(shape: DependencyList, required: true, location_name: "dependencies"))
    TextInputCard.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    TextInputCard.add_member(:placeholder, Shapes::ShapeRef.new(shape: Placeholder, location_name: "placeholder"))
    TextInputCard.add_member(:default_value, Shapes::ShapeRef.new(shape: Default, location_name: "defaultValue"))
    TextInputCard.struct_class = Types::TextInputCard

    TextInputCardInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    TextInputCardInput.add_member(:id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "id"))
    TextInputCardInput.add_member(:type, Shapes::ShapeRef.new(shape: CardType, required: true, location_name: "type"))
    TextInputCardInput.add_member(:placeholder, Shapes::ShapeRef.new(shape: Placeholder, location_name: "placeholder"))
    TextInputCardInput.add_member(:default_value, Shapes::ShapeRef.new(shape: Default, location_name: "defaultValue"))
    TextInputCardInput.struct_class = Types::TextInputCardInput

    ThrottlingException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ThrottlingException.add_member(:service_code, Shapes::ShapeRef.new(shape: String, required: true, location_name: "serviceCode"))
    ThrottlingException.add_member(:quota_code, Shapes::ShapeRef.new(shape: String, required: true, location_name: "quotaCode"))
    ThrottlingException.add_member(:retry_after_seconds, Shapes::ShapeRef.new(shape: Integer, location: "header", location_name: "Retry-After"))
    ThrottlingException.struct_class = Types::ThrottlingException

    UnauthorizedException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    UnauthorizedException.struct_class = Types::UnauthorizedException

    UntagResourceRequest.add_member(:resource_arn, Shapes::ShapeRef.new(shape: AmazonResourceName, required: true, location: "uri", location_name: "resourceARN"))
    UntagResourceRequest.add_member(:tag_keys, Shapes::ShapeRef.new(shape: TagKeys, required: true, location: "querystring", location_name: "tagKeys"))
    UntagResourceRequest.struct_class = Types::UntagResourceRequest

    UntagResourceResponse.struct_class = Types::UntagResourceResponse

    UpdateLibraryItemInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateLibraryItemInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    UpdateLibraryItemInput.add_member(:status, Shapes::ShapeRef.new(shape: LibraryItemStatus, location_name: "status"))
    UpdateLibraryItemInput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryIdList, location_name: "categories"))
    UpdateLibraryItemInput.struct_class = Types::UpdateLibraryItemInput

    UpdateLibraryItemMetadataInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateLibraryItemMetadataInput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    UpdateLibraryItemMetadataInput.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    UpdateLibraryItemMetadataInput.struct_class = Types::UpdateLibraryItemMetadataInput

    UpdateLibraryItemOutput.add_member(:library_item_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "libraryItemId"))
    UpdateLibraryItemOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    UpdateLibraryItemOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    UpdateLibraryItemOutput.add_member(:categories, Shapes::ShapeRef.new(shape: CategoryList, required: true, location_name: "categories"))
    UpdateLibraryItemOutput.add_member(:status, Shapes::ShapeRef.new(shape: String, required: true, location_name: "status"))
    UpdateLibraryItemOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    UpdateLibraryItemOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    UpdateLibraryItemOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, location_name: "updatedAt"))
    UpdateLibraryItemOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, location_name: "updatedBy"))
    UpdateLibraryItemOutput.add_member(:rating_count, Shapes::ShapeRef.new(shape: Integer, required: true, location_name: "ratingCount"))
    UpdateLibraryItemOutput.add_member(:is_rated_by_user, Shapes::ShapeRef.new(shape: Boolean, location_name: "isRatedByUser"))
    UpdateLibraryItemOutput.add_member(:user_count, Shapes::ShapeRef.new(shape: Integer, location_name: "userCount"))
    UpdateLibraryItemOutput.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    UpdateLibraryItemOutput.struct_class = Types::UpdateLibraryItemOutput

    UpdateQAppInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateQAppInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    UpdateQAppInput.add_member(:title, Shapes::ShapeRef.new(shape: Title, location_name: "title"))
    UpdateQAppInput.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    UpdateQAppInput.add_member(:app_definition, Shapes::ShapeRef.new(shape: AppDefinitionInput, location_name: "appDefinition"))
    UpdateQAppInput.struct_class = Types::UpdateQAppInput

    UpdateQAppOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    UpdateQAppOutput.add_member(:app_arn, Shapes::ShapeRef.new(shape: AppArn, required: true, location_name: "appArn"))
    UpdateQAppOutput.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    UpdateQAppOutput.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    UpdateQAppOutput.add_member(:initial_prompt, Shapes::ShapeRef.new(shape: InitialPrompt, location_name: "initialPrompt"))
    UpdateQAppOutput.add_member(:app_version, Shapes::ShapeRef.new(shape: AppVersion, required: true, location_name: "appVersion"))
    UpdateQAppOutput.add_member(:status, Shapes::ShapeRef.new(shape: AppStatus, required: true, location_name: "status"))
    UpdateQAppOutput.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    UpdateQAppOutput.add_member(:created_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "createdBy"))
    UpdateQAppOutput.add_member(:updated_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "updatedAt"))
    UpdateQAppOutput.add_member(:updated_by, Shapes::ShapeRef.new(shape: String, required: true, location_name: "updatedBy"))
    UpdateQAppOutput.add_member(:required_capabilities, Shapes::ShapeRef.new(shape: AppRequiredCapabilities, location_name: "requiredCapabilities"))
    UpdateQAppOutput.struct_class = Types::UpdateQAppOutput

    UpdateQAppPermissionsInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateQAppPermissionsInput.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    UpdateQAppPermissionsInput.add_member(:grant_permissions, Shapes::ShapeRef.new(shape: UpdateQAppPermissionsInputGrantPermissionsList, location_name: "grantPermissions"))
    UpdateQAppPermissionsInput.add_member(:revoke_permissions, Shapes::ShapeRef.new(shape: UpdateQAppPermissionsInputRevokePermissionsList, location_name: "revokePermissions"))
    UpdateQAppPermissionsInput.struct_class = Types::UpdateQAppPermissionsInput

    UpdateQAppPermissionsInputGrantPermissionsList.member = Shapes::ShapeRef.new(shape: PermissionInput)

    UpdateQAppPermissionsInputRevokePermissionsList.member = Shapes::ShapeRef.new(shape: PermissionInput)

    UpdateQAppPermissionsOutput.add_member(:resource_arn, Shapes::ShapeRef.new(shape: String, location_name: "resourceArn"))
    UpdateQAppPermissionsOutput.add_member(:app_id, Shapes::ShapeRef.new(shape: String, location_name: "appId"))
    UpdateQAppPermissionsOutput.add_member(:permissions, Shapes::ShapeRef.new(shape: PermissionsOutputList, location_name: "permissions"))
    UpdateQAppPermissionsOutput.struct_class = Types::UpdateQAppPermissionsOutput

    UpdateQAppSessionInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateQAppSessionInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    UpdateQAppSessionInput.add_member(:values, Shapes::ShapeRef.new(shape: CardValueList, location_name: "values"))
    UpdateQAppSessionInput.struct_class = Types::UpdateQAppSessionInput

    UpdateQAppSessionMetadataInput.add_member(:instance_id, Shapes::ShapeRef.new(shape: InstanceId, required: true, location: "header", location_name: "instance-id"))
    UpdateQAppSessionMetadataInput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    UpdateQAppSessionMetadataInput.add_member(:session_name, Shapes::ShapeRef.new(shape: SessionName, location_name: "sessionName"))
    UpdateQAppSessionMetadataInput.add_member(:sharing_configuration, Shapes::ShapeRef.new(shape: SessionSharingConfiguration, required: true, location_name: "sharingConfiguration"))
    UpdateQAppSessionMetadataInput.struct_class = Types::UpdateQAppSessionMetadataInput

    UpdateQAppSessionMetadataOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "sessionId"))
    UpdateQAppSessionMetadataOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    UpdateQAppSessionMetadataOutput.add_member(:session_name, Shapes::ShapeRef.new(shape: SessionName, location_name: "sessionName"))
    UpdateQAppSessionMetadataOutput.add_member(:sharing_configuration, Shapes::ShapeRef.new(shape: SessionSharingConfiguration, required: true, location_name: "sharingConfiguration"))
    UpdateQAppSessionMetadataOutput.struct_class = Types::UpdateQAppSessionMetadataOutput

    UpdateQAppSessionOutput.add_member(:session_id, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionId"))
    UpdateQAppSessionOutput.add_member(:session_arn, Shapes::ShapeRef.new(shape: String, required: true, location_name: "sessionArn"))
    UpdateQAppSessionOutput.struct_class = Types::UpdateQAppSessionOutput

    User.add_member(:user_id, Shapes::ShapeRef.new(shape: UserId, location_name: "userId"))
    User.struct_class = Types::User

    UserAppItem.add_member(:app_id, Shapes::ShapeRef.new(shape: UUID, required: true, location_name: "appId"))
    UserAppItem.add_member(:app_arn, Shapes::ShapeRef.new(shape: AppArn, required: true, location_name: "appArn"))
    UserAppItem.add_member(:title, Shapes::ShapeRef.new(shape: Title, required: true, location_name: "title"))
    UserAppItem.add_member(:description, Shapes::ShapeRef.new(shape: Description, location_name: "description"))
    UserAppItem.add_member(:created_at, Shapes::ShapeRef.new(shape: QAppsTimestamp, required: true, location_name: "createdAt"))
    UserAppItem.add_member(:can_edit, Shapes::ShapeRef.new(shape: Boolean, location_name: "canEdit"))
    UserAppItem.add_member(:status, Shapes::ShapeRef.new(shape: String, location_name: "status"))
    UserAppItem.add_member(:is_verified, Shapes::ShapeRef.new(shape: Boolean, location_name: "isVerified"))
    UserAppItem.struct_class = Types::UserAppItem

    UserAppsList.member = Shapes::ShapeRef.new(shape: UserAppItem)

    ValidationException.add_member(:message, Shapes::ShapeRef.new(shape: String, required: true, location_name: "message"))
    ValidationException.struct_class = Types::ValidationException


    # @api private
    API = Seahorse::Model::Api.new.tap do |api|

      api.version = "2023-11-27"

      api.metadata = {
        "apiVersion" => "2023-11-27",
        "auth" => ["aws.auth#sigv4"],
        "endpointPrefix" => "data.qapps",
        "protocol" => "rest-json",
        "protocols" => ["rest-json"],
        "serviceFullName" => "QApps",
        "serviceId" => "QApps",
        "signatureVersion" => "v4",
        "signingName" => "qapps",
        "uid" => "qapps-2023-11-27",
      }

      api.add_operation(:associate_library_item_review, Seahorse::Model::Operation.new.tap do |o|
        o.name = "AssociateLibraryItemReview"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.associateItemRating"
        o.input = Shapes::ShapeRef.new(shape: AssociateLibraryItemReviewInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:associate_q_app_with_user, Seahorse::Model::Operation.new.tap do |o|
        o.name = "AssociateQAppWithUser"
        o.http_method = "POST"
        o.http_request_uri = "/apps.install"
        o.input = Shapes::ShapeRef.new(shape: AssociateQAppWithUserInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:batch_create_category, Seahorse::Model::Operation.new.tap do |o|
        o.name = "BatchCreateCategory"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.createCategories"
        o.input = Shapes::ShapeRef.new(shape: BatchCreateCategoryInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:batch_delete_category, Seahorse::Model::Operation.new.tap do |o|
        o.name = "BatchDeleteCategory"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.deleteCategories"
        o.input = Shapes::ShapeRef.new(shape: BatchDeleteCategoryInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:batch_update_category, Seahorse::Model::Operation.new.tap do |o|
        o.name = "BatchUpdateCategory"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.updateCategories"
        o.input = Shapes::ShapeRef.new(shape: BatchUpdateCategoryInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:create_library_item, Seahorse::Model::Operation.new.tap do |o|
        o.name = "CreateLibraryItem"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.createItem"
        o.input = Shapes::ShapeRef.new(shape: CreateLibraryItemInput)
        o.output = Shapes::ShapeRef.new(shape: CreateLibraryItemOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:create_presigned_url, Seahorse::Model::Operation.new.tap do |o|
        o.name = "CreatePresignedUrl"
        o.http_method = "POST"
        o.http_request_uri = "/apps.createPresignedUrl"
        o.input = Shapes::ShapeRef.new(shape: CreatePresignedUrlInput)
        o.output = Shapes::ShapeRef.new(shape: CreatePresignedUrlOutput)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:create_q_app, Seahorse::Model::Operation.new.tap do |o|
        o.name = "CreateQApp"
        o.http_method = "POST"
        o.http_request_uri = "/apps.create"
        o.input = Shapes::ShapeRef.new(shape: CreateQAppInput)
        o.output = Shapes::ShapeRef.new(shape: CreateQAppOutput)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ContentTooLargeException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:delete_library_item, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DeleteLibraryItem"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.deleteItem"
        o.input = Shapes::ShapeRef.new(shape: DeleteLibraryItemInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:delete_q_app, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DeleteQApp"
        o.http_method = "POST"
        o.http_request_uri = "/apps.delete"
        o.input = Shapes::ShapeRef.new(shape: DeleteQAppInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:describe_q_app_permissions, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DescribeQAppPermissions"
        o.http_method = "GET"
        o.http_request_uri = "/apps.describeQAppPermissions"
        o.input = Shapes::ShapeRef.new(shape: DescribeQAppPermissionsInput)
        o.output = Shapes::ShapeRef.new(shape: DescribeQAppPermissionsOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:disassociate_library_item_review, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DisassociateLibraryItemReview"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.disassociateItemRating"
        o.input = Shapes::ShapeRef.new(shape: DisassociateLibraryItemReviewInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:disassociate_q_app_from_user, Seahorse::Model::Operation.new.tap do |o|
        o.name = "DisassociateQAppFromUser"
        o.http_method = "POST"
        o.http_request_uri = "/apps.uninstall"
        o.input = Shapes::ShapeRef.new(shape: DisassociateQAppFromUserInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:export_q_app_session_data, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ExportQAppSessionData"
        o.http_method = "POST"
        o.http_request_uri = "/runtime.exportQAppSessionData"
        o.input = Shapes::ShapeRef.new(shape: ExportQAppSessionDataInput)
        o.output = Shapes::ShapeRef.new(shape: ExportQAppSessionDataOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:get_library_item, Seahorse::Model::Operation.new.tap do |o|
        o.name = "GetLibraryItem"
        o.http_method = "GET"
        o.http_request_uri = "/catalog.getItem"
        o.input = Shapes::ShapeRef.new(shape: GetLibraryItemInput)
        o.output = Shapes::ShapeRef.new(shape: GetLibraryItemOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:get_q_app, Seahorse::Model::Operation.new.tap do |o|
        o.name = "GetQApp"
        o.http_method = "GET"
        o.http_request_uri = "/apps.get"
        o.input = Shapes::ShapeRef.new(shape: GetQAppInput)
        o.output = Shapes::ShapeRef.new(shape: GetQAppOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:get_q_app_session, Seahorse::Model::Operation.new.tap do |o|
        o.name = "GetQAppSession"
        o.http_method = "GET"
        o.http_request_uri = "/runtime.getQAppSession"
        o.input = Shapes::ShapeRef.new(shape: GetQAppSessionInput)
        o.output = Shapes::ShapeRef.new(shape: GetQAppSessionOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:get_q_app_session_metadata, Seahorse::Model::Operation.new.tap do |o|
        o.name = "GetQAppSessionMetadata"
        o.http_method = "GET"
        o.http_request_uri = "/runtime.getQAppSessionMetadata"
        o.input = Shapes::ShapeRef.new(shape: GetQAppSessionMetadataInput)
        o.output = Shapes::ShapeRef.new(shape: GetQAppSessionMetadataOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:import_document, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ImportDocument"
        o.http_method = "POST"
        o.http_request_uri = "/apps.importDocument"
        o.input = Shapes::ShapeRef.new(shape: ImportDocumentInput)
        o.output = Shapes::ShapeRef.new(shape: ImportDocumentOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ContentTooLargeException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:list_categories, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListCategories"
        o.http_method = "GET"
        o.http_request_uri = "/catalog.listCategories"
        o.input = Shapes::ShapeRef.new(shape: ListCategoriesInput)
        o.output = Shapes::ShapeRef.new(shape: ListCategoriesOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:list_library_items, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListLibraryItems"
        o.http_method = "GET"
        o.http_request_uri = "/catalog.list"
        o.input = Shapes::ShapeRef.new(shape: ListLibraryItemsInput)
        o.output = Shapes::ShapeRef.new(shape: ListLibraryItemsOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o[:pager] = Aws::Pager.new(
          limit_key: "limit",
          tokens: {
            "next_token" => "next_token"
          }
        )
      end)

      api.add_operation(:list_q_app_session_data, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListQAppSessionData"
        o.http_method = "GET"
        o.http_request_uri = "/runtime.listQAppSessionData"
        o.input = Shapes::ShapeRef.new(shape: ListQAppSessionDataInput)
        o.output = Shapes::ShapeRef.new(shape: ListQAppSessionDataOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:list_q_apps, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListQApps"
        o.http_method = "GET"
        o.http_request_uri = "/apps.list"
        o.input = Shapes::ShapeRef.new(shape: ListQAppsInput)
        o.output = Shapes::ShapeRef.new(shape: ListQAppsOutput)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
        o[:pager] = Aws::Pager.new(
          limit_key: "limit",
          tokens: {
            "next_token" => "next_token"
          }
        )
      end)

      api.add_operation(:list_tags_for_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "ListTagsForResource"
        o.http_method = "GET"
        o.http_request_uri = "/tags/{resourceARN}"
        o.input = Shapes::ShapeRef.new(shape: ListTagsForResourceRequest)
        o.output = Shapes::ShapeRef.new(shape: ListTagsForResourceResponse)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:predict_q_app, Seahorse::Model::Operation.new.tap do |o|
        o.name = "PredictQApp"
        o.http_method = "POST"
        o.http_request_uri = "/apps.predictQApp"
        o.input = Shapes::ShapeRef.new(shape: PredictQAppInput)
        o.output = Shapes::ShapeRef.new(shape: PredictQAppOutput)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:start_q_app_session, Seahorse::Model::Operation.new.tap do |o|
        o.name = "StartQAppSession"
        o.http_method = "POST"
        o.http_request_uri = "/runtime.startQAppSession"
        o.input = Shapes::ShapeRef.new(shape: StartQAppSessionInput)
        o.output = Shapes::ShapeRef.new(shape: StartQAppSessionOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:stop_q_app_session, Seahorse::Model::Operation.new.tap do |o|
        o.name = "StopQAppSession"
        o.http_method = "POST"
        o.http_request_uri = "/runtime.deleteMiniAppRun"
        o.input = Shapes::ShapeRef.new(shape: StopQAppSessionInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:tag_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "TagResource"
        o.http_method = "POST"
        o.http_request_uri = "/tags/{resourceARN}"
        o.input = Shapes::ShapeRef.new(shape: TagResourceRequest)
        o.output = Shapes::ShapeRef.new(shape: TagResourceResponse)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:untag_resource, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UntagResource"
        o.http_method = "DELETE"
        o.http_request_uri = "/tags/{resourceARN}"
        o.input = Shapes::ShapeRef.new(shape: UntagResourceRequest)
        o.output = Shapes::ShapeRef.new(shape: UntagResourceResponse)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_library_item, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateLibraryItem"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.updateItem"
        o.input = Shapes::ShapeRef.new(shape: UpdateLibraryItemInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateLibraryItemOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_library_item_metadata, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateLibraryItemMetadata"
        o.http_method = "POST"
        o.http_request_uri = "/catalog.updateItemMetadata"
        o.input = Shapes::ShapeRef.new(shape: UpdateLibraryItemMetadataInput)
        o.output = Shapes::ShapeRef.new(shape: Shapes::StructureShape.new(struct_class: Aws::EmptyStructure))
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ConflictException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_q_app, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateQApp"
        o.http_method = "POST"
        o.http_request_uri = "/apps.update"
        o.input = Shapes::ShapeRef.new(shape: UpdateQAppInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateQAppOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ContentTooLargeException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_q_app_permissions, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateQAppPermissions"
        o.http_method = "POST"
        o.http_request_uri = "/apps.updateQAppPermissions"
        o.input = Shapes::ShapeRef.new(shape: UpdateQAppPermissionsInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateQAppPermissionsOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_q_app_session, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateQAppSession"
        o.http_method = "POST"
        o.http_request_uri = "/runtime.updateQAppSession"
        o.input = Shapes::ShapeRef.new(shape: UpdateQAppSessionInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateQAppSessionOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)

      api.add_operation(:update_q_app_session_metadata, Seahorse::Model::Operation.new.tap do |o|
        o.name = "UpdateQAppSessionMetadata"
        o.http_method = "POST"
        o.http_request_uri = "/runtime.updateQAppSessionMetadata"
        o.input = Shapes::ShapeRef.new(shape: UpdateQAppSessionMetadataInput)
        o.output = Shapes::ShapeRef.new(shape: UpdateQAppSessionMetadataOutput)
        o.errors << Shapes::ShapeRef.new(shape: ResourceNotFoundException)
        o.errors << Shapes::ShapeRef.new(shape: AccessDeniedException)
        o.errors << Shapes::ShapeRef.new(shape: ValidationException)
        o.errors << Shapes::ShapeRef.new(shape: InternalServerException)
        o.errors << Shapes::ShapeRef.new(shape: UnauthorizedException)
        o.errors << Shapes::ShapeRef.new(shape: ServiceQuotaExceededException)
        o.errors << Shapes::ShapeRef.new(shape: ThrottlingException)
      end)
    end

  end
end
