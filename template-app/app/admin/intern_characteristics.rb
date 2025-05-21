ActiveAdmin.register BxBlockSurveys::InternCharacteristic, as: "InternCharacteristics" do
  menu label: 'Intern Characteristics', parent: 'Drop Downs', priority: 2
	permit_params :name

  actions :index, :show, :edit, :update

  filter :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

end