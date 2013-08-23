netzke-has-many
===============

Netzke HasMany is a plugin for netzke that implements a simple window with a grid that restricts the grid contents to the ID of a selected item in a parent grid.

Installation
------------

First add netzke-has-many to your Gemfile
```ruby
gem 'netzke-has-many'
```

Then run
```shell
$ bundle install
```

Usage
-----

Inside a Netzke::Basepack::Grid, include the Netzke::HasMany::Base model and use has_many, like you would use in your ActiveRecord model

Example:
```ruby
class Hospital < ActiveRecord::Base
  has_many :patients
end

class Patient < ActiveRecord::Base
  belongs_to :hospital
  attr_accessible :name
end

class HospitalGrid < Netzke::Basepack::Grid
  include Netzke::HasMany::Base
  has_many :patients

  def configure(c)
    c.model = 'Hospital'
  end
end
```

By default, it will generate a default Grid, with force_fit = true and all columns

If you want to specify what columns, you can do instead
```ruby
has_many :patients, columns: [:name]
```

Or, if you want a nicer customized Grid, you can pass it as grid_klass
```ruby
has_many :patients, grid_klass: MyPatientGrid
```

License
-------
The MIT License (MIT)

Copyright (c) 2013 Bernardo Amorim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.