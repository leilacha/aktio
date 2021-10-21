# Test technique Aktio

## Instructions

L'objectif est de générer un bilan d'émissions de gaz à effet de serre (`data/output.json`) à partir d'une liste de données d'activité se rapportant à des facteurs d'émission (`data/input.json`).

Le bilan d'émissions sera regroupé par site et par catégorie et devra comporter les informations suivantes :

- Pour chacune des catégories :

  - valeur totale

- Pour chacune des émissions :

  - id
  - activity_datum_id
  - description
  - unité agrégée
  - valeur totale
  - valeur détaillée par gaz

Toutes les valeurs (totale ou détaillée par gaz) sont exprimées en équivalent CO₂, dans les émissions et les facteurs d'émission. La valeur totale sera donc l'addition des différents gaz *à l'exception du carbone biogénique* (CO₂b). 🤓 En effet, le carbone biogénique est le carbone fixé par un combustible (comme le bois d'un arbre par exemple) à partir du CO₂ de l’air et qui sera réémis lors de sa combustion.

Attention, certains facteurs d'émission s'expriment avec deux unités combinées (par exemple, en tonne * kilomètre).

A titre d'exemple, voici un extrait de ce qu'on devrait retrouver dans `data/output.json` :

```json
{
  "entrepôt - Limoges": {
    "transports": {
      "total_value": 744013.92,
      "emissions": [
        {
          "id": 1,
          "description": "diesel routier",
          "unit": "kgCO2e/tonne.km",
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
  },
  "entrepôt - Poitiers": {
    ...
  }
}
```

## Précisions

- Le programme doit être appelable de la manière suivante `$ ruby aktio.rb`
- Nous apprécions le code propre, robuste et bien architecturé : n'ayez pas peur de l'OOP.
- Merci de cloner et non forker le repo
