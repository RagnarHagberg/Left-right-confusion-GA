import json
from typing import Tuple, List, Any, Dict
import os
import statistics
import pandas as pd

def divide_into_start_direction(data) -> Tuple[List[Dict], List[Dict], List[Dict], List[Dict]]:
    from_top = []
    from_bottom = []
    from_left = []
    from_right = []

    for value in data.values():
        print(value["start_direction"])
        if value["start_direction"] == "hÃ¶ger":
            from_right.append(value)
        if value["start_direction"] == "vÃ¤nster":
            from_left.append(value)
        if value["start_direction"] == "ovan":
            from_top.append(value)
        if value["start_direction"] == "nederst":
            from_bottom.append(value)

    return from_top, from_bottom, from_left, from_right



def analyze_category(category_name, values):
    total_time = 0
    correct = 0
    wrong = 0
    value_count = len(values)
    for value in values:
        total_time += float(value["time"])
        if bool(value["correct"]):
            correct += 1

    average_time = total_time/value_count
    wrong = value_count - correct
    print("average_time", average_time)
    print("correct", correct)
    print("wrong", wrong)
    percentage_right = round(correct / value_count, 3)

    print("percentage right", percentage_right)

    return {category_name: {"Average_time": average_time, "Correct": correct, "Wrong": wrong, "Percentage_right": percentage_right}}

def analyze_data(data):


    # Directional analysis
    from_top, from_bottom, from_left, from_right = divide_into_start_direction(data)

    print("Top: ")
    analyzed_data = []

    top_analyzed = analyze_category("From_top", from_top)
    analyzed_data.append(top_analyzed)

    print("Bottom: ")
    bottom_analyzed = analyze_category("From_bottom", from_bottom)
    analyzed_data.append(bottom_analyzed)

    print("Left: ")
    left_analyzed = analyze_category("From_left", from_left)
    analyzed_data.append(left_analyzed)

    print("Right: ")
    right_analyzed = analyze_category("From_right", from_right)
    analyzed_data.append(right_analyzed)

    # General analysis

    total_time = 0
    total_correct = 0
    total_wrong = 0

    category_data = {}
    for category in analyzed_data:
        category_data[f"{list(category.keys())[0]}Correct"] = (list(category.values())[0]["Correct"])
        category_data[f"{list(category.keys())[0]}Wrong"] = (list(category.values())[0]["Wrong"])
        category_data[f"{list(category.keys())[0]}Average_time"] = (list(category.values())[0]["Average_time"])
        category_data[f"{list(category.keys())[0]}Percentage_correct"] = (list(category.values())[0]["Percentage_right"])

        total_correct += (list(category.values())[0]["Correct"])
        total_wrong += (list(category.values())[0]["Wrong"])
        total_time += (list(category.values())[0]["Average_time"])

    average_time = total_time/len(analyzed_data)


    percentage_correct = round(total_correct/(total_correct + total_wrong), 3)

    total_data = {"Average_time": average_time, "Total_correct": total_correct, "Total_wrong": total_wrong,
            "Percentage_correct": percentage_correct}
    total_dict = dict(list(total_data.items()) + list(category_data.items()))
    return (total_dict)


def main():
    path = "Data/Test2"
    directory = os.fsencode(path)

    total_data = []
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if filename.endswith(".save"):
            with open(path + "/" + filename) as f:
                data = json.load(f)
                analyzed_data = analyze_data(data)
                analyzed_data["Name"] = filename.split(".")[0]
                total_data.append(analyzed_data)
        else:
            continue

    df = pd.DataFrame(total_data)
    print(df)
    df.to_csv(f"AnalyzedData2.csv", index=False)

if __name__ == '__main__':
    main()
