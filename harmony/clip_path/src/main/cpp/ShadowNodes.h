
/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateShadowNodeH.js
 */

#pragma once

// #include <react/renderer/components/RTNCenteredTextSpec/EventEmitters.h>
// #include <react/renderer/components/RTNCenteredTextSpec/Props.h>
// #include <react/renderer/components/RTNCenteredTextSpec/States.h>
#include "EventEmitters.h"
#include "Props.h"
#include "States.h"
#include <react/renderer/components/view/ConcreteViewShadowNode.h>
#include <jsi/jsi.h>

namespace facebook {
namespace react {

JSI_EXPORT extern const char ClipPathComponentName[];

/*
 * `ShadowNode` for <RTNCenteredText> component.
 */
using ClipPathShadowNode = ConcreteViewShadowNode<
    ClipPathComponentName,
    ClipPathProps,
    ClipPathEventEmitter,
    ClipPathState>;

} // namespace react
} // namespace facebook
