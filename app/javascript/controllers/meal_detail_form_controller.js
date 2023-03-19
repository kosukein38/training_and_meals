import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-detail-form"
export default class extends Controller {
  static targets = ["mealDetailForm"]

  add() {
    const targetForm = this.mealDetailFormTargets.find(form => form.classList.contains('hidden'));
    console.log(this.mealDetailFormTargets);
    if (targetForm) {
      targetForm.classList.remove('hidden');
    }
  }
  
  delete() {
    const visibleForms = this.mealDetailFormTargets.filter(form => !form.classList.contains('hidden'));
    if (visibleForms.length > 0) {
      const lastVisibleForm = visibleForms[visibleForms.length - 1];
      lastVisibleForm.classList.add('hidden');
      const inputs = lastVisibleForm.querySelectorAll('input[type="text"], input[type="number"]');
      inputs.forEach(input => input.value = '');
    }
  }
}
