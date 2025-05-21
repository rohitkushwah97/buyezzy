module BxBlockLikeAPostPolicies
  class LikeAPostPolicy < ::BxBlockLikeAPostPolicies::ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      true
    end
  end
end
