# -*- encoding : utf-8 -*-

ActiveAdmin.register MarkdownPage do
  actions :index, :update, :edit, :show
  menu parent: 'settings'
  filter :name

  sidebar :markdown, only: :edit do
    para I18n.t_md('admin.markdown_page.markdown_info_markdown').html_safe
  end

  index do
    column :friendly_name
    default_actions
  end

  show title: :friendly_name do |page|
    attributes_table do
      row :id
      row :friendly_name
      row :preview do
        # Pass the document through erb, then through Kramdown
        erb_page = ERB.new(page.content).result(binding)
        Kramdown::Document.new(erb_page).to_html.html_safe
      end
      row :content do
        simple_format CGI.escapeHTML(page.content)
      end
    end
  end

  form do |f|
    f.inputs I18n.t('admin.markdown_page.page_header',
                    name: markdown_page.friendly_name) do
      f.input :content, input_html: { rows: 30 }
    end
    f.buttons
  end
end
