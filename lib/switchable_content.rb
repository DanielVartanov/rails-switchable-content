module ActionView
  module Helpers
    module SwitchableContent
      def switchable_content
        block_key = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        block_id = "switchable_block_#{block_key}"

        return <<HTML
        <input type="checkbox" onchange="block = document.getElementById('#{block_id}'); if (this.checked) {block.style.display = 'block'} else {block.style.display = 'none'}" />
        <div id="#{block_id}" style="display:block">
          #{yield}
        </div>
HTML
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActionView::Helpers::SwitchableContent
end