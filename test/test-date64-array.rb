# Copyright 2017 Kouhei Sutou <kou@clear-code.com>
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

class Date64ArrayTest < Test::Unit::TestCase
  test("#[]") do
    n_msecs_since_epoch = 1503878400000 # 2017-08-28T00:00:00Z
    array = Arrow::Date64Array.new([n_msecs_since_epoch])
    assert_equal(DateTime.new(2017, 8, 28, 0, 0, 0),
                 array[0])
  end
end
