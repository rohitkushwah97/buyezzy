module AccountBlock
  class BusinessUserSerializer
    include FastJsonapi::ObjectSerializer

     attributes(:email, :activated)

  end
end