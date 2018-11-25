import React from 'react';
import cx from "classnames";

import { connect } from "react-redux";
import { getProgress } from "../redux/selectors";

class StepTracker extends React.Component {

  render() {
    const { progress } = this.props

    return (
      <div>
        <h1 className="text-purple-darkest text-3xl flex align-middle">
          <span className="bg-purple-darkest text-white rounded-full h-12 w-12 flex items-center justify-center mr-8 -mt-2">{progress.step}</span>
          Gift Options
        </h1>
        <div className="flex mt-8 mr-8">
          <div className="w-1/8">
          </div>
          <div className={cx("w-1/8 text-center opacity-25", progress.step == 1 && "opacity-100")}>
            <span className="bg-purple-darkest rounded-full mx-auto flex h-4 w-4 mb-2"></span>
            <p className="font-bold text-grey-darker text-sm">Gift Options</p>
          </div>
          <div className="w-1/8">
            <div className="w-4/5 mx-auto border-t border-grey-light border-solid mt-2"></div>
          </div>
          <div className={cx("w-1/8 text-center opacity-25", progress.step == 2 && "opacity-100")}>
            <span className="bg-purple-darkest rounded-full mx-auto flex h-4 w-4 mb-2"></span>
            <p className="text-grey-darker text-sm">Personal Info</p>
          </div>
          <div className="w-1/8">
            <div className="w-4/5 mx-auto border-t border-grey-light border-solid mt-2"></div>
          </div>
          <div className={cx("w-1/8 text-center opacity-25", progress.step == 3 && "opacity-100")}>
            <span className="bg-purple-darkest rounded-full mx-auto flex h-4 w-4 mb-2"></span>
            <p className="text-grey-darker text-sm">payment</p>
          </div>
          <div className="w-1/8">
            <div className="w-4/5 mx-auto border-t border-grey-light border-solid mt-2"></div>
          </div>
          <div className={cx("w-1/8 text-center opacity-25", progress.step == 4 && "opacity-100")}>
            <span className="bg-purple-darkest rounded-full mx-auto flex h-4 w-4 mb-2"></span>
            <p className="text-grey-darker text-sm">Review</p>
          </div>
        </div>
      </div>
    )
  }
}
export default connect(state => ({ progress: getProgress(state) }))(StepTracker);
