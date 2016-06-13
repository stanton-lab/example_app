module ApplicationHelper
  def sidebar_items
    {
      dashboard: {
        icon:   'desktop',
        name:   'Dashboard',
        url:    root_path,
        access: can?(:read, :dashboard),
        active: -> { current_menu?(:dashboard) }
      },
      employees: {
        icon:     'users',
        name:     'Персонал',
        url:      '#',
        access:   can?(:read, :employees),
        active:   -> { current_menu?(:departments, :managers) },
        subitems: {
          department: {
            name:   'Отделы',
            url:    departments_path,
            access: can?(:read, Department),
            active: -> { current_menu?(:departments) }
          },
          users: {
            name:   'Сотрудники',
            url:    managers_path,
            access: can?(:read, Manager),
            active: -> { current_menu?(:managers) }
          }
        }
      },
      clients: {
        icon: 'male',
        name: 'Клиенты',
        url:  clients_path,
        access: can?(:read, :clients),
        active: -> { current_menu?(:clients) }
      },
      works:     {
        icon: 'ship',
        name: 'Виды услуг',
        url:  works_path,
        access: can?(:read, :works),
        active: -> { current_menu?(:works) }
      },
      projects:     {
        icon: 'industry',
        name: 'Проекты',
        url:  projects_path,
        access: can?(:read, :projects),
        active: -> { current_menu?(:projects) }
      },
      periods: {
        icon: 'money',
        name: 'Курсы валют',
        url:  periods_path,
        access: can?(:read, :periods),
        active: -> { current_menu?(:periods) }
      }
    }
  end

  def current_menu?(*controller_names)
    controller_names.include? controller.controller_name.to_sym
  end

  def bootstrap_flash_class(flash_type)
    { success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def active_class(path = nil, &block)
    return if block.blank? && path.blank?
    if block.present?
      return 'active' if block.call
    end
    if path.present?
      return 'active' if current_page?(path)
    end
  end
end
