const mongoose = require("mongoose");

const PremiumPlanHistorySchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    premiumPlanId: { type: mongoose.Schema.Types.ObjectId, ref: "PremiumPlan" },
    paymentGateway: { type: String },
    razorpayPaymentId: { type: String, default: null },
    razorpayOrderId: { type: String, default: null },
    razorpaySignature: { type: String, default: null },
    date: { type: String },
  },
  {
    timestamps: false,
    versionKey: false,
  }
);

PremiumPlanHistorySchema.index({ userId: 1 });
PremiumPlanHistorySchema.index({ premiumPlanId: 1 });

module.exports = mongoose.model("PremiumPlanHistory", PremiumPlanHistorySchema);
