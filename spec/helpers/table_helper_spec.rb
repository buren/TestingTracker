require 'rails_helper'

RSpec.describe TableHelper, type: :helper do

  let (:header_opts) { { header: ['test1', 'test2', 'test3'] } }
  let (:header_html) { "<thead><tr><th>test1</th><th>test2</th><th>test3</th></tr></thead>" }
  let (:content_opts) { { content: [[1,2,3],[2,3,5],[3,5,8]] } }
  let (:content_html) { "<tbody><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>2</td><td>3</td><td>5</td></tr><tr><td>3</td><td>5</td><td>8</td></tr></tbody>" }

  it 'creates and calls a table generator' do
    opts = {
      header: ['test1', 'test2', 'test3'],
      content: [["1",2,3],[2,3,5],[3,5,8]]
    }
    expect(generate_table(opts)).to eq(TableHelper::TableBuilder.new(opts).generate)
  end

  it 'generates headers for tables' do
    opts = header_opts
    expect(generate_table(opts)).to eq("<table class=\"table\">#{header_html}</table>")
  end

  it 'generates bodies for tables' do
    opts = content_opts
    expect(generate_table(opts)).to eq("<table class=\"table\">#{content_html}</table>")
  end

end
