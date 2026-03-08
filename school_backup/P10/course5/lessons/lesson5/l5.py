import pandas as pd
data = {
    "Age": [10, 20, 30, 40, 50],
    "Module": [60, 70, 80, 90, 100]
}
category_series = pd.DataFrame (data)
print (category_series.head ())
