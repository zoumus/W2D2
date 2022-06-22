require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return true if salaries.has_key?(title)
        false 
    end

    def >(startup)
        return true if funding > startup.funding
        false
    end

    def hire(name, title)
        if !@salaries.has_key?(title)
            raise 'title is invalid' 
        else
            @employees << Employee.new(name, title)
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @salaries[employee.title] <= @funding
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise 'no money'
        end

    end

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += @salaries[employee.title]
        end
        sum/@employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title, pay|
            @salaries[title] = pay if !salaries.has_key?(title)
        end
        startup.employees.each do |employee|
            @employees << employee
        end
        startup.close
    end

end
