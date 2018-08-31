require './02/simple.rb'

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end

Machine.new(
  Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
  { x: Number.new(2) }
).run

Machine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2)),
  ),
  { x: Boolean.new(true) }
).run
