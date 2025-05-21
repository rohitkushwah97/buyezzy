class AddDataInEducationalStatuses < ActiveRecord::Migration[6.1]
  def change
    data = [{name: "High School", code: "SCH"}, {name: "University", code: "UNI"}, {name: "Graduate", code: "GRA"}]
    data.each do |rec|
      BxBlockProfile::EducationalStatus.create(rec)
    end
  end
end
