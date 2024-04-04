require "pagy/extras/overflow"

Pagy::DEFAULT[:items] = 20
Pagy::DEFAULT[:size] = [1, 1, 1, 1]
Pagy::DEFAULT[:overflow] = :last_page
