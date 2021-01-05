class Admin::UserService
  def get_admin_list(type, page)
    data = User.where({ role: type }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    table_header = ["id", "email", "first_name", "last_name", "role"]
    hidden_column = [0]

    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: UserAdminSerializer)
    return {
             page: page,
             type: type,
             tabelData: datas,
             total_data: total_data,
             total_page: total_pages,
             tableHeaders: table_header,
             hiddenColumn: hidden_column,
             maxRow: 25,
           }
  end
end
