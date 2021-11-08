class Task < ApplicationRecord
    def complete_task
        self.complete = !self.complete
    end
end
