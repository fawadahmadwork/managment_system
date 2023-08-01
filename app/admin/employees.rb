ActiveAdmin.register Employee do
  member_action :create_salary_slip, method: :get do
    redirect_to new_admin_salary_slip_path(salary_slip: { employee_id: resource.id })
  end
  action_item :create_salary_slip, only: :show do
    link_to 'Create Salary Slip', create_salary_slip_admin_employee_path(employee)
  end
  member_action :create_salary_detail, method: :get do
    if resource.salary_detail.present?

      redirect_to edit_admin_salary_detail_path(resource.salary_detail),
                  notice: 'Salary detail already exists for this employee.'
    else
      # Create a new salary detail and redirect to the salary detail edit page
      salary_detail = SalaryDetail.create(employee_id: resource.id)
      redirect_to edit_admin_salary_detail_path(salary_detail), notice: 'Salary detail created successfully!'
    end
  end

  action_item :create_salary_detail, only: :show do
    link_to 'Create Salary Detail', create_salary_detail_admin_employee_path(employee)
  end

  form do |f|
    f.inputs do
      f.input :first_name, input_html: { class: 'text-color' }
      f.input :last_name, input_html: { class: 'text-color' }
      f.input :gender, as: :select, collection: %w[Male Female]
      f.input :date_of_birth, as: :datepicker, palceholder: 'yyyy-mm-dd'
      f.input :national_id_card, length: { maximum: 15 },
                                 format: { with: /\A\d{5}-\d{7}-\d{1}\z/, message: "should be in the format '12345-1234567-1'" }
      f.input :designation
      f.input :department
      f.input :date_of_joining, as: :datepicker
      f.input :termination_date, as: :datepicker
      f.input :avatar, as: :file, input_html: { accept: 'image/jpeg, image/png', maxlength: 5.megabytes }
      f.input :employment_status
      f.input :address, as: :text
      f.input :notes

      f.has_many :emails, allow_destroy: true do |email_form|
        email_form.input :email
      end
      f.has_many :phone_numbers, allow_destroy: true do |phone_form|
        phone_form.input :phone_number, input_html: { pattern: '\+\d{2}-\d{4}-\{7}' }, placeholder: '+92-0322-4713041'
      end
    end
    f.has_many :bank_account_details, allow_destroy: true do |bank_account_form|
      bank_account_form.input :bank_name
      bank_account_form.input :branch_name
      bank_account_form.input :account_title
      bank_account_form.input :account_number
    end
    f.actions
  end
  index do
    selectable_column
    id_column
    column 'Full Name', sortable: :last_name do |employee|
      "#{employee.first_name} #{employee.last_name}"
    end
    column :age do |employee|
      if employee.date_of_birth.present?
        calculate_age(employee.date_of_birth)
      else
        'N/A'
      end
    end

    column :gender
    column :designation
    column :department
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :gender
      row :age do |employee|
        if employee.date_of_birth.present?
          calculate_age(employee.date_of_birth)
        else
          'N/A'
        end
      end
      row :date_of_birth
      row :email do |employee|
        if employee.emails.any?
          employee.emails.first.email
        else
          'N/A'
        end
      end
      row :phone_number do |employee|
        if employee.phone_numbers.any?
          employee.phone_numbers.first.phone_number
        else
          'N/A'
        end
      end
      row :address
      row :national_id_card
      row :designation
      row :department
      row :date_of_joining
      row :termination_date
      row :notes
      row :employment_status
      row :avatar do |employee|
        if employee.avatar.attached?
          image_tag url_for(employee.avatar), height: '100px', width: '100px'
        else
          'N/A'
        end
      end

      panel 'Emails' do
        table_for employee.emails do
          column :email
        end
      end
      panel 'Phone Numbers' do
        table_for employee.phone_numbers do
          column :phone_number
        end
      end
      panel 'Bank Account Details' do
        table_for employee.bank_account_details do
          column :bank_name
          column :branch_name
          column :account_title
          column :account_number
        end
      end
    end
    active_admin_comments
  end

  controller do
    def new
      @employee = Employee.new
      @employee.phone_numbers.build
      @employee.emails.build
      @employee.bank_account_details.build
    end
  end

  permit_params :first_name, :last_name, :age, :gender, :date_of_birth, :address, :national_id_card,
                :designation, :department, :date_of_joining, :termination_date, :avatar, :notes, :employment_status,
                emails_attributes: %i[id email _destroy],
                phone_numbers_attributes: %i[id phone_number _destroy],
                bank_account_details_attributes: %i[id account_title account_number bank_name branch_name _destroy]
end
def calculate_age(date_of_birth)
  return '' if date_of_birth.blank?

  age = Date.today.year - date_of_birth.year
  age -= 1 if Date.today < date_of_birth + age.years
  age
end
