# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# pin compiled bootstrap js
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true

pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "simplebar", to: "https://ga.jspm.io/npm:simplebar@6.2.5/dist/index.mjs"
pin "can-use-dom", to: "https://ga.jspm.io/npm:can-use-dom@0.1.0/index.js"
pin "lodash-es", to: "https://ga.jspm.io/npm:lodash-es@4.17.21/lodash.js"
pin "simplebar-core", to: "https://ga.jspm.io/npm:simplebar-core@1.2.4/dist/index.mjs"
