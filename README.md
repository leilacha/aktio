# Test technique Aktio

## Instructions

L'objectif est de générer un bilan d'émissions carbone (`data/output.json`) à partir d'une liste de données d'activité se rapportant à des facteurs d'émission (`data/input.json`).

Le bilan d'émissions sera regroupé par catégorie et devra comporter les informations suivantes pour chacune des émissions :

- id
- activity_datum_id
- description
- unité agrégée
- valeur totale
- valeur détaillée par gaz

Les valeurs d'émission par gaz rapportées dans les facteurs d'émission sont exprimées en équivalent CO₂. La valeur totale sera donc l'addition des différents gaz *à l'exception du carbone biogénique* (CO₂b). 🤓 En effet, le carbone biogénique est le carbone fixé par la plante à partir du CO2 de l’air et qui sera réémis lors de sa combustion.

A titre d'exemple, voici un extrait de ce qu'on devrait retrouver dans `data/output.json` pour la catégorie `Transports` :

```json
{
  "transports": {
    "emissions": [
      {
        "id": 1,
        "description": "diesel routier",
        "unit": "kgCO2e/t.km",
        "total_value": 744000,
        "value_co2": 744000,
        "value_ch4": null,
        "value_n2o": null,
        "value_co2b": null,
        "value_ch4b": null,
        "activity_datum_id": 2
      },
      ...
    ]
  },
  ...
}
```

## Précisions

- Le programme doit être appelable de la manière suivante `$ ruby aktio.rb`
- Nous apprécions le code propre, robuste et bien architecturé : n'ayez pas peur de l'OOP.






