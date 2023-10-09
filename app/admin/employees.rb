ActiveAdmin.register Employee do
  config.sort_order = 'id_asc'
  form do |f|
    f.inputs do
      f.input :first_name, as: :string, input_html: { style: 'text-transform: capitalize;' }
      f.input :last_name, as: :string, input_html: { style: 'text-transform: capitalize;' }
      f.input :date_of_birth, as: :datepicker, datepicker_options: {
                                                 changeMonth: true,
                                                 changeYear: true,
                                                 yearRange: '1970:2008'
                                               },
                              input_html: { id: 'date-of-birth' }
      f.input :age, input_html: { id: 'age', readonly: true }

      f.input :gender, as: :select, collection: %w[Male Female],
                       include_blank: false

      f.input :national_id_card, length: { maximum: 15 },
                                 input_html: {
                                   placeholder: 'i-e 12345-1234567-1', class: 'national-id-input'
                                 }
      f.input :employment_type, as: :select,
                                collection: %w[FullTime PartTime Contractor],
                                include_blank: false

      f.input :department, as: :select, collection: ['Development', 'Quality Assurance'], include_blank: false

      f.input :designation, as: :select, collection: [],
                            include_blank: false, input_html: { id: 'employee_designation', 'data-saved-designation': f.object.designation }

      f.input :employment_status, as: :select,
                                  collection: %w[Active Inactive Freeze], id: 'employment-status-select',
                                  include_blank: false

      f.input :freezing_date, as: :datepicker, id: 'freezing-date-input'
      f.input :freezing_comment, as: :text, id: 'freezing-comment-input'

      f.input :date_of_joining, as: :datepicker, datepicker_options: { changeYear: true, yearRange: '2015:c' }

      if f.object.new_record?

        f.input :termination_date, as: :datepicker, label: false, input_html: { style: 'display: none;' }
      else

        f.input :termination_date, as: :datepicker
      end

      f.input :avatar, as: :file, input_html: { id: 'avatar-input' }
      if f.object.avatar.attached?
        div id: 'avatar-preview', style: 'margin-left: 300px;' do
          image_tag url_for(f.object.avatar), id: 'avatar-image', style: 'max-width: 100px;'
        end
      else
        div id: 'avatar-preview', style: 'display: none; margin-left: 300px;' do
          image_tag '', id: 'avatar-image', style: 'max-width: 100px;'
        end
      end

      f.input :signup_bonus
      f.input :address, as: :text
      f.input :notes

      f.has_many :emails, allow_destroy: true do |email_form|
        email_form.input :email
      end
      f.has_many :phone_numbers, allow_destroy: true do |phone_form|
        phone_form.input :phone_number,
                         input_html: { placeholder: '0300-1234567', pattern: '\d{4}-\d{7}',
                                       id: 'phone_number_input_id' }
      end
    end
    f.has_many :bank_account_details, allow_destroy: true do |bank_account_form|
      bank_account_form.input :bank_name
      bank_account_form.input :account_title
      bank_account_form.input :branch_code,
                              input_html: {
                                placeholder: 'Enter a 4-digit branch code',
                                oninput: "this.value = this.value.slice(0, 4); this.value = this.value.replace(/[^0-9]/g, '');",
                                type: 'text'
                              }
      bank_account_form.input :account_number, input_html: {
        placeholder: 'Please enter account number',
        oninput: "this.value = this.value.replace(/[^0-9]/g, '');",
        type: 'text'
      }
      bank_account_form.input :IBAN, input_html: {
        pattern: 'PK\d{2}[A-Za-z]{4}\d{16}',
        placeholder: ' (e.g., PK36SCBL0000001123456702)',
        oninput: 'this.value = this.value.toUpperCase();',
        onkeypress: 'return /[a-zA-Z0-9]/.test(event.key)'
      }
    end
    f.actions
  end

  filter :first_name_or_last_name_cont, as: :string, label: 'Name Contains'
  filter :emails_email, as: :select, collection: -> { Email.pluck(:email).uniq }, label: 'Email'
  filter :department, as: :select, collection: ['Development', 'Quality Assurance'], include_blank: true
  filter :designation, as: :select,
                       collection: ['Internee', 'Software Engineer', 'Software Engineer-L1', 'Software Engineer-L2', 'SQA', 'Senior SQA'], include_blank: true

  index do
    selectable_column
    id_column
    column 'Full Name', sortable: :last_name do |employee|
      link_to "#{employee.first_name} #{employee.last_name}", admin_employee_path(employee)
    end
    column :avatar do |employee|
      if employee.avatar.attached?
        div class: 'avatar-wrapper' do
          link_to(url_for(employee.avatar), target: '_blank') do
            image_tag url_for(employee.avatar), style: 'max-width: 50px;'
          end
        end
      else
        'N/A'
      end
    end
    column :phone_number do |employee|
      if employee.phone_numbers.any?
        employee.phone_numbers.first.phone_number
      else
        'N/A'
      end
    end
    column :email do |employee|
      if employee.emails.any?
        employee.emails.first.email
      else
        'N/A'
      end
    end
    column :department
    column :designation

    actions
  end
  show do
    attributes_table do
      row :first_name
      row :last_name
      row :gender
      row :age
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
      row :employment_type
      row :department
      row :designation
      row :employment_status
      if employee.employment_status == 'Freeze'
        row :freezing_date if resource.freezing_date.present?
        row :freezing_comment if resource.freezing_comment.present?
      end
      row :signup_bonus
      row :starting_salary do |employee|
        first_salary_history = employee.salary_detail_histories.order(created_at: :asc).first
        first_salary_history&.net_salary || 'N/A'
      end
      row :date_of_joining
      row :termination_date if resource.termination_date.present?
      row :notes if resource.notes.present?
      row :avatar do |employee|
        if employee.avatar.attached?
          div class: 'avatar-wrapper' do
            link_to(url_for(employee.avatar), target: '_blank') do
              image_tag url_for(employee.avatar), style: 'max-width: 50px;'
            end
          end
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
          column :branch_code
          column :account_title
          column :account_number
          column :IBAN
        end
      end
    end

    panel 'Salary Structures' do
      if employee.salary_structure.present?
        attributes_table_for employee.salary_structure do
        end

        div do
          link_to 'View Salary Structure', admin_salary_structure_path(employee.salary_structure), class: 'button'
        end

        div style: 'margin-top: 10px;' do
          link_to 'View Salary Detail Histories',
                  admin_salary_detail_histories_path(q: { salary_structure_id_eq: employee.salary_structure.id }),
                  class: 'button'
        end
      else
        div do
          link_to 'Create Salary Structure', new_admin_salary_structure_path(employee_id: employee.id),
                  class: 'button'
        end
      end
    end
    panel 'Salary Slips' do
      if employee.salary_slips.present?
        div style: 'margin-top: 10px;' do
          link_to 'View Salary Slips', admin_salary_slips_path(q: { employee_id_eq: employee.id }), class: 'button'
        end
      else
        div style: 'margin-top: 10px;' 'No salary slips available.'
      end
      div style: 'margin-top: 10px;' do
        link_to 'Create New Salary Slip', new_admin_salary_slip_path(employee_id: employee.id), class: 'button'
      end
    end
    panel 'Provident fund' do
      link_to 'View Provident Fund', admin_employee_provident_fund_path(employee_id: resource.id), class: 'button'
    end
    panel 'All Salaries Paid' do
      link_to 'View all Salaries paid', admin_employee_salary_slips_path(employee_id: resource.id), class: 'button'
    end

    active_admin_comments
  end

  controller do
    def create
      @employee = Employee.new(permitted_params[:employee])

      if @employee.save
        flash[:notice] = 'Employee was successfully created!'
        redirect_to admin_employee_path(@employee)
      else
        flash[:error] = 'Your form is missing or has incomplete fields. Please review your entry below.'
        render action: 'new'
      end
    end

    def new
      @employee = Employee.new
      @employee.phone_numbers.build
      @employee.emails.build
      @employee.bank_account_details.build
    end

    def employee_id_present?
      resource.employee_id.present?
    end

    def edit
      @employee = Employee.find(params[:id])

      # Pre-select the designation based on the saved value
      @selected_designation = @employee.designation

      super
    end
  end
  controller do
    def update
      super do |format|
        if resource.valid? && resource.saved_change_to_designation?
          resource.update_salary_structure_from_template
          flash[:notice] = "Employee's salary structure updated based on new designation."
          format.html { redirect_to edit_admin_salary_structure_path(resource.salary_structure) }
        end
      end
    end
  end
  permit_params :first_name, :last_name, :age, :gender, :date_of_birth, :address, :national_id_card,
                :designation, :department, :date_of_joining, :termination_date, :avatar, :notes, :employment_status, :employment_type, :freezing_date, :freezing_comment, :starting_salary, :signup_bonus,
                emails_attributes: %i[id email _destroy],
                phone_numbers_attributes: %i[id phone_number _destroy],
                bank_account_details_attributes: %i[id account_title account_number bank_name branch_code IBAN _destroy]
end
