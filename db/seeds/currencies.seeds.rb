Currency.delete_all
Currency.create!([
                   {
                     id:      1,
                     name: 'RUB',
                     default: 0.37
                   },
                   {
                     id:      2,
                     name: 'EUR',
                     default: 29
                   },
                   {
                     id:      3,
                     name: 'USD',
                     default: 25
                   }
                 ])
