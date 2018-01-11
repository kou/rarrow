# Copyright 2017-2018 Kouhei Sutou <kou@clear-code.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Arrow
  class TableFormatter
    def initialize(table, options={})
      @table = table
      @options = options
    end

    def format
      text = ""
      columns = @table.columns
      format_header(text, columns)

      n_rows = @table.n_rows
      return text if n_rows.zero?

      border = @options[:border] || 10
      n_digits = (Math.log10(n_rows) + 1).truncate
      head_limit = [border, n_rows].min
      head_column_values = columns.collect do |column|
        column.each.take(head_limit)
      end
      format_rows(text,
                  columns,
                  head_column_values.transpose,
                  n_digits,
                  0)
      return text if n_rows <= border

      format_ellipsis(text)

      tail_start = [border, n_rows - border].max
      tail_limit = n_rows - tail_start
      tail_column_values = columns.collect do |column|
        column.reverse_each.take(tail_limit).reverse
      end
      format_rows(text,
                  columns,
                  tail_column_values.transpose,
                  n_digits,
                  tail_start)

      text
    end
  end
end
