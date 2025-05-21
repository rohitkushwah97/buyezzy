class CreateJoinTableAccountsInternships < ActiveRecord::Migration[6.1]
 def change
    create_join_table :accounts, :internships, table_name: 'accounts_bx_block_navmenu_internships' do |t|
      t.index [:account_id, :internship_id], name: 'index_acc_internship_on_account_id', unique: true
      t.index [:internship_id, :account_id], name: 'index_internship_acc_on_internship_id', unique: true
    end
  end
end
