ActiveAdmin.register Employee do
  form do |f|
    f.inputs do
      f.input :first_name, input_html: { class: 'text-color' }
      f.input :last_name, input_html: { class: 'text-color' }
      f.input :gender, as: :select, collection: %w[Male Female]
      f.input :date_of_birth, as: :datepicker, datepicker_options: {
        changeMonth: true,
        changeYear: true,
        yearRange: '1970:2008'

      }

      f.input :national_id_card, length: { maximum: 15 },
                                 input_html: {
                                   placeholder: 'i-e 12345-1234567-1'
                                 }

      f.input :employment_status, as: :select,
                                  collection: %w[Active Inactive Freeze]
      f.input :department, as: :select, collection: ['Quality Assurance', 'Development']

      f.input :designation, as: :select,
                            collection: ['Intern', 'Software Engineer', 'L1, Software Engineer', 'L2, Software Engineer']

      f.input :date_of_joining, as: :datepicker, datepicker_options: { changeYear: true, yearRange: '2015:c' }

      if f.object.new_record?

        f.input :termination_date, as: :datepicker, label: false, input_html: { style: 'display: none;' }
      else

        f.input :termination_date, as: :datepicker
      end
      f.input :avatar, as: :file,
                       hint: f.object.avatar.attached? ? image_tag(f.object.avatar.variant(resize: '150x150')) : ''
      f.input :address, as: :text
      f.input :notes

      f.has_many :emails, allow_destroy: true do |email_form|
        email_form.input :email
      end
      f.has_many :phone_numbers, allow_destroy: true do |phone_form|
        phone_form.input :phone_number, input_html: { pattern: '\+\d{2}-\d{4}-\{7}' }, placeholder: '0300-1234567'
      end
    end
    f.has_many :bank_account_details, allow_destroy: true do |bank_account_form|
      bank_account_form.input :bank_name
      bank_account_form.input :account_title
      bank_account_form.input :branch_name
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
      row :first_name, id: 'first-name-row'
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

    panel 'Salary Details' do
      if employee.salary_detail.present?
        # Display existing salary details and a link to view them
        attributes_table_for employee.salary_detail do
          row :id
          # Add other salary detail attributes here
        end
        # Link to view the existing salary details
        link_to 'View Salary Detail', admin_salary_detail_path(employee.salary_detail), class: 'button'
      else
        # If salary detail does not exist, show link to create it
        link_to 'Create Salary Detail', new_admin_salary_detail_path(employee_id: employee.id), class: 'button'
      end
    end
    div class: 'hide-button' do
      button type: 'button', id: 'hide-first-name-button', class: 'button', 'data-action': 'hide-first-name' do
        'Hide First Name'
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
