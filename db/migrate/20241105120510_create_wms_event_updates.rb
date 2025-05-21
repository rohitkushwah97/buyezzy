class CreateWmsEventUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :wms_event_updates do |t|
      t.string :warehouse_code
      t.string :seller_email
      t.string :consignment_type
      t.string :shipment_number
      t.string :po_number
      t.string :old_state
      t.string :new_state
      t.datetime :event_on
      t.string :time_zone
      t.json :products

      t.timestamps
    end
  end
end
