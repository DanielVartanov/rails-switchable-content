module ActionView
  module Helpers
    module SwitchableContent
      def switchable_content(&block)
        block_key = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        block_id = "switchable_block_#{block_key}"

        html = <<HTML
<input type="checkbox" checked onchange="block = document.getElementById('#{block_id}'); if (this.checked) {block.style.display = 'block'} else {block.style.display = 'none'}" />
<div id="#{block_id}" style="display:block">
  #{capture(&block)}
</div>
HTML
        html.each { |line| concat(line, block.binding) }
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActionView::Helpers::SwitchableContent
end