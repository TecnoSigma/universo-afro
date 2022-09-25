# Create image credits (copyright)
Credit.create(url: 'https://www.flaticon.com/free-icons/building',
              title: 'building icons',
              description: 'Building icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/long-hair',
              title: 'long hair icons',
              description: 'Long hair icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.flaticon.com/free-icons/surgeon',
              title: 'surgeon icons',
              description: 'Surgeon icons created by Freepik - Flaticon')

Credit.create(url: 'https://www.freepik.com/free-vector/simple-background-with-geometric-elements_17665233.htm#&position=0&from_view=collections',
              title: 'Image by visnezh on Freepik',
              description: 'Image by visnezh on Freepik')

# Create States and Cities
Tasks::PlacesGenerator.call!
#State.create(name: 'São Paulo', external_id: 1)
#State.create(name: 'Minas Gerais', external_id: 2)

#City.create(name: 'Mauá', state: State.first)
#City.create(name: 'Belo Horizonte', state: State.last)

# Create Professions
Tasks::ProfessionsGenerator.call!
#Profession.create(name: 'Arquivista')
#Profession.create(name: 'Office-Boy')
