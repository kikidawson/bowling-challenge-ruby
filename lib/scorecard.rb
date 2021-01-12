class Scorecard
  attr_reader :frames, :regular_total, :current_frame

  def initialize
    @frames = []
    @regular_total = 0
    @bonus_total = 0
    @current_frame = []
  end

  def roll(pins)
    @current_frame << pins

    if final_frame?
      final_frame << pins
      bonus_add(pins)
      bonus_add(pins) if two_rolls_in(final_frame) && strike?(last_frame)
    else
      if strike?(@current_frame) || two_rolls_in(@current_frame)
        @frames << @current_frame
        add_sum_to_regular
        if not_first_frame?
          if strike?(last_frame)
            add_sum_to_bonus
            bonus_first_roll_if_second_last_strike
          elsif spare?(last_frame)
            bonus_add(first_roll)
          end
        end
        reset_frame
      end
    end
end

  def total
    @regular_total + @bonus_total
  end

  private

  def sum(frame)
    frame.inject(:+)
  end

  def bonus_first_roll_if_second_last_strike
    bonus_add(first_roll) if not_second_frame? && strike?(second_last_frame)
  end

  def first_roll
    @current_frame[0]
  end

  def bonus_add(points)
    @bonus_total += points
  end

  def last_frame
    @frames[-2]
  end

  def second_last_frame
    @frames[-3]
  end

  def strike?(frame)
    frame[0] == 10
  end

  def spare?(frame)
    sum(frame) == 10
  end

  def reset_frame
    @current_frame = []
  end

  def final_frame?
    @frames.length == 10
  end

  def final_frame
    @frames[-1]
  end

  def two_rolls_in(frame)
    frame.length == 2
  end

  def add_sum_to_regular
    @regular_total += sum(@current_frame)
  end

  def add_sum_to_bonus
    @bonus_total += sum(@current_frame)
  end

  def not_first_frame?
    @frames.length > 1
  end

  def not_second_frame?
    @frames.length > 2
  end

end
